// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:async';

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_toolkit/session/session_navigator.dart';

import 'amplifyconfiguration.dart';
import 'auth/auth_repository.dart';
import 'models/ModelProvider.dart';
import 'repository/ocr_record_repository.dart';
import 'repository/storage_repository.dart';
import 'repository/user_repository.dart';
import 'session/session_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    unawaited(_configureAmplify());
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        builder: Authenticator.builder(),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthRepository()),
            RepositoryProvider(create: (context) => UserRepository()),
            RepositoryProvider(
              create: (context) => OCRRecordRepository(),
            ),
            RepositoryProvider(create: (context) => StorageRepository()),
          ],
          child: BlocProvider(
            create: (context) => SessionCubit(
              authRepo: context.read<AuthRepository>(),
              dataRepo: context.read<UserRepository>(),
            ),
            child: const SessionNavigator(),
          ),
        ),
      ),
    );
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAPI(modelProvider: ModelProvider.instance),
        AmplifyAuthCognito(),
        AmplifyStorageS3(),
        AmplifyAnalyticsPinpoint(),
      ]);
      await Amplify.configure(amplifyconfig);

      safePrint('Successfully configured Amplify.');
    } on Exception catch (e) {
      safePrint('Could not configure Amplify. error: $e');
    }
  }
}
