// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/auth/auth_repository.dart';
import '/models/User.dart';
import '/repository/user_repository.dart';
import '/service/analytics/analytics_events.dart';
import '/service/analytics/analytics_service.dart';
import '/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final UserRepository dataRepo;

  String get currentUserId => (state as Authenticated).userId;

  User get currentUser => (state as Authenticated).user;

  SessionCubit({required this.authRepo, required this.dataRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      print("attemptAutoLogin, start.");
      final userId = await authRepo.attemptAutoLogin();
      User? user = await dataRepo.getUserById(userId);
      if (user == null) {
        signOut(); // Sign out and go to login page.
        throw Exception("user not found in database, please login.");
      }
      AnalyticsService.log(AutoLoginEvent(true));
      emit(Authenticated(userId: userId, user: user));
      print("attemptAutoLogin, success.");
    } on Exception {
      AnalyticsService.log(AutoLoginEvent(false));
      emit(Unauthenticated());
      print("attemptAutoLogin, failed.");
    }
  }

  void createSession(String userId, String username) async {
    User? user = await dataRepo.getUserById(userId);
    if (user == null) {
      final email = await authRepo.getUserEmailFromAttributes();
      final deviceId = await _getDeviceId();
      user = await dataRepo.createUser(userId: userId, username: username, email: email, deviceId: deviceId);
    }
    emit(Authenticated(userId: userId, user: user));
    print('session created.');
  }

  void signOut() {
    _destroySession();
  }

  void _destroySession() {
    authRepo.signOut();
    AnalyticsService.log(SignOutEvent());
    emit(Unauthenticated());
    print('session destroyed.');
  }

  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }
}
