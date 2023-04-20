// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpUsernameChanged extends SignUpEvent {
  const SignUpUsernameChanged({required this.username});

  final String username;
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged({required this.email});

  final String email;
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged({required this.password});

  final String password;
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
