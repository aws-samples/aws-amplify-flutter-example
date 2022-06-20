// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '/models/User.dart';

class UserRepository {
  Future<User?> getUserById(String userId) async {
    try {
      final request = ModelQueries.get(User.classType, userId);
      final response = await Amplify.API.query(request: request).response;
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> createUser({
    required String userId,
    required String username,
    required String email,
    String? deviceId,
  }) async {
    final newUser = User(id: userId, username: username, email: email, deviceId: deviceId ?? "");
    try {
      final request = ModelMutations.create(newUser);
      final response = await Amplify.API.mutate(request: request).response;
      final user = response.data;
      if (user == null) {
        throw Exception('failed to create user, ${response.errors.toString()}');
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final request = ModelMutations.update(user);
      final response = await Amplify.API.mutate(request: request).response;
      final updatedUser = response.data;
      if (updatedUser == null) {
        throw Exception('failed to update user, ${response.errors.toString()}');
      }
      return updatedUser;
    } catch (e) {
      rethrow;
    }
  }
}
