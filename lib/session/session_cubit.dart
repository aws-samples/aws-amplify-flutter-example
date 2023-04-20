// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/auth/auth_repository.dart';
import '/models/User.dart';
import '/repository/user_repository.dart';
import '/service/analytics/analytics_events.dart';
import '/service/analytics/analytics_service.dart';
import '/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required this.authRepo, required this.dataRepo})
      : super(const UnknownSessionState()) {
    attemptAutoLogin();
    Amplify.Hub.listen(HubChannel.Auth, (event) {
      final user = event.payload;
      switch (event.type) {
        case AuthHubEventType.signedIn:
          createSession(user!.userId, user.username);
          break;
        case AuthHubEventType.signedOut:
        case AuthHubEventType.sessionExpired:
        case AuthHubEventType.userDeleted:
          emit(const Unauthenticated());
          break;
      }
    });
  }

  final AuthRepository authRepo;
  final UserRepository dataRepo;

  String get currentUserId => (state as Authenticated).userId;

  User get currentUser => (state as Authenticated).user;

  Future<void> attemptAutoLogin() async {
    try {
      safePrint('attemptAutoLogin, start.');
      final userId = await authRepo.attemptAutoLogin();
      final user = await dataRepo.getUserById(userId);
      if (user == null) {
        signOut(); // Sign out and go to login page.
        throw Exception('user not found in database, please login.');
      }
      AnalyticsService.log(AutoLoginEvent(true));
      emit(Authenticated(userId: userId, user: user));
      safePrint('attemptAutoLogin, success.');
    } on Exception {
      AnalyticsService.log(AutoLoginEvent(false));
      emit(const Unauthenticated());
      safePrint('attemptAutoLogin, failed.');
    }
  }

  void createSession(String userId, String username) async {
    var user = await dataRepo.getUserById(userId);
    if (user == null) {
      final email = await authRepo.getUserEmailFromAttributes();
      final deviceId = await _getDeviceId();
      user = await dataRepo.createUser(
        userId: userId,
        username: username,
        email: email,
        deviceId: deviceId,
      );
    }
    emit(Authenticated(userId: userId, user: user));
    safePrint('session created.');
  }

  void signOut() {
    AnalyticsService.log(SignOutEvent());
    authRepo.signOut();
  }

  Future<String?> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
}
