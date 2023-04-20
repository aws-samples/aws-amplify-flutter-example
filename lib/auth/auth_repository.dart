// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    return currentUser.userId;
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
}
