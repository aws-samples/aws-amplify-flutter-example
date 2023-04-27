// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {
  const FormSubmitting();
}

class SubmissionSuccess extends FormSubmissionStatus {
  const SubmissionSuccess();
}

class SubmissionFailed extends FormSubmissionStatus {
  const SubmissionFailed({required this.exception});

  final Exception exception;
}
