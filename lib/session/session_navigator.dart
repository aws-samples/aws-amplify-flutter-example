// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app_nav_cubit.dart';
import '/app_navigator.dart';
import '/auth/auth_cubit.dart';
import '/auth/auth_navigator.dart';
import '/loading_view.dart';
import '/session/session_cubit.dart';
import '/session/session_state.dart';

class SessionNavigator extends StatelessWidget {
  const SessionNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) const MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: const AuthNavigator(),
              ),
            ),

          // Show session flow, managed by AppNavigator.
          if (state is Authenticated)
            MaterialPage(
                child: BlocProvider(
              create: (context) => AppNavCubit(),
              child: const AppNavigator(),
            )),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
