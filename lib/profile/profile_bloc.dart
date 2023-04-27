// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart'
    hide Emitter, StorageCategory;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/models/User.dart';
import '/profile/profile_event.dart';
import '/profile/profile_state.dart';
import '/repository/storage_repository.dart';
import '/repository/user_repository.dart';
import '/service/analytics/analytics_events.dart';
import '/service/analytics/analytics_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.dataRepo,
    required this.storageRepo,
    required User user,
  }) : super(ProfileState(user: user)) {
    if (user.avatarKey != null) {
      storageRepo
          .getUrl4PublicFile(user.avatarKey!)
          .then((url) => add(ProvideImagePath(avatarPath: url)));
    }

    on<ChangeAvatarRequest>(
      (event, emit) =>
          emit(state.copyWith(imageSourceActionSheetIsVisible: true)),
    );
    on<OpenImagePicker>(_openImagePicker);
    on<ProvideImagePath>(
      (event, emit) => emit(state.copyWith(avatarPath: event.avatarPath)),
    );
  }
  final UserRepository dataRepo;
  final StorageRepository storageRepo;

  final _picker = ImagePicker();

  void _openImagePicker(
    OpenImagePicker event,
    Emitter<ProfileState> emit,
  ) async {
    safePrint('_openImagePicker, imageSource: ${event.imageSource}');

    emit(state.copyWith(imageSourceActionSheetIsVisible: false));
    final pickedImage = await _picker.pickImage(source: event.imageSource);
    if (pickedImage == null) return;

    AnalyticsService.log(ChangeAvatarEvent(event.imageSource));
    emit(state.copyWith(uploading: true));
    // upload image then update user.
    final imageKey = await storageRepo.uploadPublicFile(
      category: StorageCategory.avatar,
      file: File(pickedImage.path),
    );
    final updatedUser = state.user.copyWith(avatarKey: imageKey);
    final results = await Future.wait([
      dataRepo.updateUser(updatedUser),
      storageRepo.getUrl4PublicFile(imageKey),
    ]);
    emit(state.copyWith(uploading: false));
    emit(state.copyWith(avatarPath: results.last as String));
  }
}
