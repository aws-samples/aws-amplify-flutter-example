// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:convert';

import '../record.dart';

enum LoadingState { initial, inProgress, success, failed }

class OCRContent {
  final String words;
  final double score;

  OCRContent(this.words, this.score);
}

class OCRDetailState {
  final String? id;
  final Record? record;
  List<OCRContent>? contentList;
  LoadingState loadingState;
  final Exception? error;

  OCRDetailState({
    this.id,
    this.record,
    this.loadingState = LoadingState.initial,
    this.error,
  }) {
    contentList = _parseContent(record?.content);
  }

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

  List<OCRContent> _parseContent(String? content) {
    if (content == null) return [];

    final List<dynamic> dataList = jsonDecode(content);
    List<OCRContent> list = [];
    for (Map<String, dynamic> item in dataList) {
      list.add(OCRContent(item["words"], item["score"]));
    }
    return list;
  }
}
