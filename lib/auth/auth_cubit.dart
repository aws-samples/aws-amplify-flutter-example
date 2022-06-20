// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';
import '/auth/auth_credentials.dart';
import '/session/session_cubit.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;
  AuthCredentials? credentials;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);

  // The parameters from sign_up_view
  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmSignUp);
  }

  void createSessionAfterAuth(String userId, String username) => sessionCubit.createSession(userId, username);

}
