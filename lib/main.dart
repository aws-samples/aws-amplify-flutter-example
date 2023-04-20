// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/amplifyconfiguration.dart';
import '/auth/auth_repository.dart';
import '/loading_view.dart';
import '/models/ModelProvider.dart';
import '/repository/ocr_record_repository.dart';
import '/repository/storage_repository.dart';
import '/repository/user_repository.dart';
import '/session/session_cubit.dart';
import '/session/session_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isAmplifyConfigured
          ? MultiRepositoryProvider(
              providers: [
                RepositoryProvider(create: (context) => AuthRepository()),
                RepositoryProvider(create: (context) => UserRepository()),
                RepositoryProvider(create: (context) => OCRRecordRepository()),
                RepositoryProvider(create: (context) => StorageRepository()),
              ],
              child: BlocProvider(
                create: (context) => SessionCubit(
                  authRepo: context.read<AuthRepository>(),
                  dataRepo: context.read<UserRepository>(),
                ),
                child: const SessionNavigator(),
              ),
            )
          : const LoadingView(),
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

      setState(() => _isAmplifyConfigured = true);

      safePrint('Successfully configured Amplify.');
    } on Exception catch (e) {
      safePrint('Could not configure Amplify. error: $e');
    }
  }
}
