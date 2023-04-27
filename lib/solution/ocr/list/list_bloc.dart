// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart'
    hide Emitter, StorageCategory;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/models/OCRRecord.dart';
import '/repository/ocr_record_repository.dart';
import '/repository/storage_repository.dart';
import '/session/session_cubit.dart';
import '../record.dart';
import 'list_event.dart';
import 'list_state.dart';

class OCRListBloc extends Bloc<OCRListEvent, OCRListState> {
  OCRListBloc({
    required this.ocrRecordRepo,
    required this.storageRepo,
    required this.sessionCubit,
  }) : super(const OCRListState()) {
    on<OCRListRefreshEvent>(_refresh);
    on<OCRListLoadingMoreEvent>(_loadingMore);
    on<UploadImageRequest>(
      (event, emit) =>
          emit(state.copyWith(imageSourceActionSheetIsVisible: true)),
    );
    on<OpenImagePicker>(_openImagePicker);
  }

  final OCRRecordRepository ocrRecordRepo;
  final StorageRepository storageRepo;
  final SessionCubit sessionCubit;

  PaginatedResult<OCRRecord>? _paginatedResult;

  final _picker = ImagePicker();

  void _refresh(OCRListRefreshEvent event, Emitter<OCRListState> emit) async {
    emit(state.copyWith(loadingState: LoadingState.inProgress));

    try {
      _paginatedResult = await ocrRecordRepo.queryOCRRecordsOfUser(
        userId: sessionCubit.currentUserId,
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.success,
          records: await _parse(_paginatedResult!.items),
          canLoadNextPage: false,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(loadingState: LoadingState.failed, error: e));
    }
  }

  void _loadingMore(
    OCRListLoadingMoreEvent event,
    Emitter<OCRListState> emit,
  ) async {
    if (_paginatedResult != null && _paginatedResult!.hasNextResult) {
      _paginatedResult = await ocrRecordRepo.queryOCRRecordsOfUser(
        userId: sessionCubit.currentUserId,
        requestForNextResult: _paginatedResult!.requestForNextResult,
      );
      emit(state.appendRecords(await _parse(_paginatedResult!.items)));
    }
  }

  void _openImagePicker(
    OpenImagePicker event,
    Emitter<OCRListState> emit,
  ) async {
    safePrint('_openImagePicker, imageSource: ${event.imageSource}');

    emit(state.copyWith(imageSourceActionSheetIsVisible: false));
    final pickedImage = await _picker.pickImage(source: event.imageSource);
    if (pickedImage == null) return;

    emit(state.copyWith(uploading: true));
    // upload image then update table.
    final uuid = UUID.getUUID();
    final imageKey = await storageRepo.uploadPrivateFile(
      category: StorageCategory.ocrImage,
      file: File(pickedImage.path),
      uuid: uuid,
    );

    await ocrRecordRepo.saveOCRRecord(
      OCRRecord(
        id: uuid,
        privateKey: imageKey,
        // fullKey: 'private/${sessionCubit.identityId}/$imageKey}',
        userID: sessionCubit.currentUserId,
      ),
    );
    emit(state.copyWith(uploading: false));
    add(const OCRListRefreshEvent());
  }

  Future<List<Record>> _parse(List<OCRRecord?> list) async {
    if (list.isEmpty) {
      return [];
    }

    final records = list.map((e) async {
      final url = await storageRepo.getUrl4PrivateFile(e!.privateKey!);
      return Record(id: e.id, url: url, createdAt: e.createdAt);
    });
    final newList = await Future.wait(records);
    newList.sort(
      (a, b) => a.createdAt == null || b.createdAt == null
          ? 1
          : b.createdAt!.compareTo(a.createdAt!),
    );
    return newList;
  }
}
