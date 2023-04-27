// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import '../record.dart';

enum LoadingState { initial, inProgress, success, failed }

class OCRListState {
  const OCRListState({
    this.records,
    this.canLoadNextPage,
    this.loadingState = LoadingState.initial,
    this.imageSourceActionSheetIsVisible = false,
    this.uploading = false,
    this.error,
  });

  final bool imageSourceActionSheetIsVisible;
  final bool uploading;

  final LoadingState loadingState;
  final List<Record>? records;
  final bool? canLoadNextPage;

  final Exception? error;

  OCRListState copyWith({
    List<Record>? records,
    bool? canLoadNextPage,
    LoadingState? loadingState,
    bool? imageSourceActionSheetIsVisible,
    bool? uploading,
    Exception? error,
  }) {
    return OCRListState(
      records: records ?? this.records,
      canLoadNextPage: canLoadNextPage ?? this.canLoadNextPage,
      loadingState: loadingState ?? this.loadingState,
      imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
          this.imageSourceActionSheetIsVisible,
      uploading: uploading ?? this.uploading,
      error: error ?? this.error,
    );
  }

  OCRListState appendRecords(List<Record> records) {
    return copyWith(records: [...this.records!, ...records]);
  }
}
