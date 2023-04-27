// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class OCRDetailEvent {
  const OCRDetailEvent();
}

class OCRDetailLoadEvent extends OCRDetailEvent {
  const OCRDetailLoadEvent({required this.id});

  final String id;
}

class OCRDetailRefreshEvent extends OCRDetailEvent {
  const OCRDetailRefreshEvent();
}

class OCRDetailClearEvent extends OCRDetailEvent {
  const OCRDetailClearEvent();
}
