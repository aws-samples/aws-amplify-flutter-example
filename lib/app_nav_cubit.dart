// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';

enum AppNavState { bottomNavBar, ocrSolutionInHome }

class AppNavCubit extends Cubit<AppNavState> {
  AppNavCubit() : super(AppNavState.bottomNavBar);

  // Bottom Navigation Bar
  void showHome() => emit(AppNavState.bottomNavBar);

  void showBottomNavBar() => emit(AppNavState.bottomNavBar);

  // In home
  void showOCRSolutionInHome() => emit(AppNavState.ocrSolutionInHome);
}
