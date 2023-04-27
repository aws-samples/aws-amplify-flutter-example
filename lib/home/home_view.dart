// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app_nav_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Toolkit'),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
              child: ListTile(
                title: const Text('Text Recognition (OCR) Solution'),
                subtitle: const Text(
                  'Automatically recognize text from images, and return the '
                  'coordinate position and confidence scores of the text.',
                ),
                trailing:
                    const Icon(Icons.arrow_circle_right_outlined, size: 38),
                isThreeLine: true,
                onTap: () => BlocProvider.of<AppNavCubit>(context)
                    .showOCRSolutionInHome(),
              ),
            ),
          ),
          const Card(
            child: ListTile(
              title: Text(
                'Coming Soon...',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
