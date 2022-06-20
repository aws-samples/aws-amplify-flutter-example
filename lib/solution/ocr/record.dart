// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_core/amplify_core.dart';

class Record {
  final String id;
  final String url;
  final TemporalDateTime? createdAt;
  final String? content;

  Record({
    required this.id,
    required this.url,
    this.createdAt,
    this.content,
  });
}
