// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import '/home/home_navigator.dart';
import '/profile/profile_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: BlocBuilder<BottomNavBarCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state,
              children: const [HomeNavigator(), ProfileView()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) =>
                  context.read<BottomNavBarCubit>().selectTab(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
