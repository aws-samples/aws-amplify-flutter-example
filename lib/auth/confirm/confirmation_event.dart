// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class ConfirmationEvent {}

class ConfirmationCodeChanged extends ConfirmationEvent {
  final String code;

  ConfirmationCodeChanged({required this.code});
}

class ConfirmationSubmitted extends ConfirmationEvent {}
