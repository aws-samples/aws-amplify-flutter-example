// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

