// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/home/home_navigator_cubit.dart';
import '/home/home_view.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigatorCubit(),
      child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: const [
              MaterialPage(child: HomeView()),
            ],
            onPopPage: (route, result) {
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
