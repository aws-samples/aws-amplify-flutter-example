// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/OCRRecord.dart';
import '/repository/ocr_record_repository.dart';
import '/repository/storage_repository.dart';
import '../record.dart';
import 'detail_event.dart';
import 'detail_state.dart';

class OCRDetailBloc extends Bloc<OCRDetailEvent, OCRDetailState> {
  OCRDetailBloc({
    required this.ocrRecordRepo,
    required this.storageRepo,
  }) : super(OCRDetailState()) {
    on<OCRDetailLoadEvent>(_load);
    on<OCRDetailRefreshEvent>(_refresh);
    on<OCRDetailClearEvent>(_clear);
  }

  final OCRRecordRepository ocrRecordRepo;
  final StorageRepository storageRepo;

  void _load(OCRDetailLoadEvent event, Emitter<OCRDetailState> emit) async {
    emit(state.copyWith(loadingState: LoadingState.inProgress, id: event.id));

    await _loadData(event.id, emit);
  }

  void _refresh(
    OCRDetailRefreshEvent event,
    Emitter<OCRDetailState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.inProgress));

    await _loadData(state.id!, emit);
  }

  Future<void> _loadData(String id, Emitter<OCRDetailState> emit) async {
    try {
      final record = await ocrRecordRepo.getOCRRecordById(id);
      emit(
        state.copyWith(
          loadingState: LoadingState.success,
          record: await _parse(record!),
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void _clear(OCRDetailClearEvent event, Emitter<OCRDetailState> emit) async {
    emit(OCRDetailState());
  }

  Future<Record> _parse(OCRRecord record) async {
    final url = await storageRepo.getUrl4PrivateFile(record.privateKey!);
    return Record(id: record.id, url: url, content: record.content);
  }
}
