// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class ConfirmationEvent {
  const ConfirmationEvent();
}

class ConfirmationCodeChanged extends ConfirmationEvent {
  const ConfirmationCodeChanged({required this.code});

  final String code;
}

class ConfirmationSubmitted extends ConfirmationEvent {
  const ConfirmationSubmitted();
}
