// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/auth/auth_cubit.dart';
import '/auth/confirm/confirmation_view.dart';
import '/auth/login/login_view.dart';
import '/auth/sign_up/sign_up_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            // Show login
            if (state == AuthState.login)
              const MaterialPage(child: LoginView()),

            // Allow push animation
            if (state == AuthState.signUp ||
                state == AuthState.confirmSignUp) ...[
              // Show Sign up
              const MaterialPage(child: SignUpView()),

              // Show confirm sign up
              if (state == AuthState.confirmSignUp)
                const MaterialPage(child: ConfirmationView())
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
