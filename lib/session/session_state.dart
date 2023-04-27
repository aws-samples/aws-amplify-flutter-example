// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import '/models/User.dart';

abstract class SessionState {
  const SessionState();
}

class UnknownSessionState extends SessionState {
  const UnknownSessionState();
}

class Unauthenticated extends SessionState {
  const Unauthenticated();
}

class Authenticated extends SessionState {
  const Authenticated({required this.userId, required this.user});

  final String userId;
  final User user;
}
