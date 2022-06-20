// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_flutter/amplify_flutter.dart';

import 'analytics_events.dart';

class AnalyticsService {
  static void log(AbstractAnalyticsEvent event) {
    Amplify.Analytics.recordEvent(event: event.value);
  }
}
