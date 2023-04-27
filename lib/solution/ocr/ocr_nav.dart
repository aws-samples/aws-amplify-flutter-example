// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail/detail_bloc.dart';
import 'detail/detail_view.dart';
import 'list/list_bloc.dart';
import 'list/list_event.dart';
import 'list/list_view.dart';
import 'ocr_nav_cubit.dart';

class OCRNavigator extends StatelessWidget {
  const OCRNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final ocrDetailBloc = OCRDetailBloc(
      ocrRecordRepo: context.read(),
      storageRepo: context.read(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OCRNavCubit(ocrDetailBloc: ocrDetailBloc),
        ),
        BlocProvider(create: (context) => ocrDetailBloc),
        BlocProvider(
          create: (context) => OCRListBloc(
            ocrRecordRepo: context.read(),
            storageRepo: context.read(),
            sessionCubit: context.read(),
          )..add(const OCRListRefreshEvent()),
        ),
      ],
      child: BlocBuilder<OCRNavCubit, String?>(
        builder: (context, state) {
          return Navigator(
            pages: [
              // Show list page.
              const MaterialPage(child: OCRListView()),
              // Show detail page.
              if (state != null) const MaterialPage(child: OCRDetailView()),
            ],
            onPopPage: (route, result) {
              BlocProvider.of<OCRNavCubit>(context).popToList();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
