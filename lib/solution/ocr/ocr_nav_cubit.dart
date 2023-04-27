// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';

import '/solution/ocr/detail/detail_event.dart';
import 'detail/detail_bloc.dart';

class OCRNavCubit extends Cubit<String?> {
  OCRNavCubit({required this.ocrDetailBloc}) : super(null);

  final OCRDetailBloc ocrDetailBloc;

  void showOCRDetail(String id) {
    emit(id);
    ocrDetailBloc.add(OCRDetailLoadEvent(id: id));
  }

  void popToList() {
    emit(null);
    ocrDetailBloc.add(const OCRDetailClearEvent());
  }
}
