// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_flutter/amplify_flutter.dart';

class Record {
  const Record({
    required this.id,
    required this.url,
    this.createdAt,
    this.content,
  });

  final String id;
  final String url;
  final TemporalDateTime? createdAt;
  final String? content;
}
