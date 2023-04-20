// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_nav_cubit.dart';
import 'bottom_nav_bar/bottom_nav_bar_view.dart';
import 'solution/ocr/ocr_nav.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavCubit, AppNavState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == AppNavState.bottomNavBar)
              const MaterialPage(child: BottomNavBar()),

            // Home
            if (state == AppNavState.ocrSolutionInHome)
              const MaterialPage(child: OCRNavigator()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
