// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn
        ? (await _getUserIdFromAttributes())
        : throw Exception('auto login failed.');
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    final result = await Amplify.Auth.signIn(
      username: username.trim(),
      password: password.trim(),
    );

    return result.isSignedIn
        ? (await _getUserIdFromAttributes())
        : throw Exception('login failed.');
  }

  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final options = SignUpOptions(
      userAttributes: {
        CognitoUserAttributeKey.email: email.trim(),
      },
    );
    final result = await Amplify.Auth.signUp(
      username: username.trim(),
      password: password.trim(),
      options: options,
    );
    return result.isSignUpComplete;
  }

  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    final result = await Amplify.Auth.confirmSignUp(
      username: username.trim(),
      confirmationCode: confirmationCode.trim(),
    );
    return result.isSignUpComplete;
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }

  Future<String> getUserEmailFromAttributes() async {
    // sub, email, email_verified
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final email = attributes
        .firstWhere((element) => element.userAttributeKey.key == 'email')
        .value;
    return email;
  }

  Future<String> _getUserIdFromAttributes() async {
    // sub, email, email_verified
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final userId = attributes
        .firstWhere((element) => element.userAttributeKey.key == 'sub')
        .value;
    return userId;
  }
}
