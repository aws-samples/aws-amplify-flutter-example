// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import '/models/User.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final String userId;
  final User user;

  Authenticated({required this.userId, required this.user});
}
