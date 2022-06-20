// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

class AuthCredentials {
  final String username;
  final String password;
  final String? email;
  String? userId;

  AuthCredentials({
    required this.username,
    required this.password,
    this.email,
    this.userId,
  });
}
