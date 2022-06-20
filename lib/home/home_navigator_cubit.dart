// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeNavigatorState { home }

class HomeNavigatorCubit extends Cubit<HomeNavigatorState> {
  HomeNavigatorCubit() : super(HomeNavigatorState.home);

  void showHome() => emit(HomeNavigatorState.home);
}
