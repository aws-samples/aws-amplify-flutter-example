// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import '/auth/form_submission_status.dart';
import '/models/User.dart';

class ProfileState {
  const ProfileState({
    required this.user,
    this.avatarPath,
    this.formStatus = const InitialFormStatus(),
    this.imageSourceActionSheetIsVisible = false,
    this.uploading = false,
  });

  final User user;
  final String? avatarPath;

  final FormSubmissionStatus formStatus;
  final bool imageSourceActionSheetIsVisible;
  final bool uploading;

  ProfileState copyWith({
    User? user,
    String? avatarPath,
    FormSubmissionStatus? formStatus,
    bool? imageSourceActionSheetIsVisible,
    bool? uploading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      avatarPath: avatarPath ?? this.avatarPath,
      formStatus: formStatus ?? this.formStatus,
      imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
          this.imageSourceActionSheetIsVisible,
      uploading: uploading ?? this.uploading,
    );
  }
}
