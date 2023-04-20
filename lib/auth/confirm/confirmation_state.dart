// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import '/auth/form_submission_status.dart';

class ConfirmationState {
  const ConfirmationState({
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  final String code;
  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus formStatus;

  ConfirmationState copyWith({
    String? code,
    FormSubmissionStatus? formStatus,
  }) {
    return ConfirmationState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
