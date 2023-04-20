// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:convert';

import '../record.dart';

enum LoadingState { initial, inProgress, success, failed }

class OCRContent {
  const OCRContent(this.words, this.score);

  final String words;
  final double score;
}

class OCRDetailState {
  OCRDetailState({
    this.id,
    this.record,
    this.loadingState = LoadingState.initial,
    this.error,
  }) : contentList = _parseContent(record?.content);

  final String? id;
  final Record? record;
  final List<OCRContent>? contentList;
  final LoadingState loadingState;
  final Exception? error;

  OCRDetailState copyWith({
    String? id,
    Record? record,
    LoadingState? loadingState,
    Exception? error,
  }) {
    return OCRDetailState(
      id: id ?? this.id,
      record: record ?? this.record,
      loadingState: loadingState ?? this.loadingState,
      error: error ?? this.error,
    );
  }

  static List<OCRContent> _parseContent(String? content) {
    if (content == null) return [];

    final dataList = jsonDecode(content) as List<dynamic>;
    final list = <OCRContent>[];
    for (final item in dataList.cast<Map<String, dynamic>>()) {
      list.add(
        OCRContent(item['words'] as String, item['score'] as double),
      );
    }
    return list;
  }
}
