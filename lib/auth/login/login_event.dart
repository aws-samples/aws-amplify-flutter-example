// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class LoginEvent {
  const LoginEvent();
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged({required this.username});

  final String username;
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({required this.password});

  final String password;
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
