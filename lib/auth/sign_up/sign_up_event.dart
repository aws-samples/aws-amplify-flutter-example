// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpSubmitted extends SignUpEvent {}
