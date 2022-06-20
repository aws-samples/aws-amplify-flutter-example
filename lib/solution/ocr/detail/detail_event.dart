// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

abstract class OCRDetailEvent {}

class OCRDetailLoadEvent extends OCRDetailEvent {
  final String id;

  OCRDetailLoadEvent({required this.id});
}

class OCRDetailRefreshEvent extends OCRDetailEvent {}

class OCRDetailClearEvent extends OCRDetailEvent {}
