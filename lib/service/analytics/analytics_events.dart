// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:image_picker/image_picker.dart';

abstract class AbstractAnalyticsEvent {
  final AnalyticsEvent value;

  AbstractAnalyticsEvent.withName({required String eventName}) : value = AnalyticsEvent(eventName);

  AbstractAnalyticsEvent.withEvent({required AnalyticsEvent event}) : value = event;
}

class LoginEvent extends AbstractAnalyticsEvent {
  final bool success;

  LoginEvent(this.success) : super.withName(eventName: "login") {
    value.properties.addBoolProperty("success", success);
  }
}

class AutoLoginEvent extends AbstractAnalyticsEvent {
  final bool success;

  AutoLoginEvent(this.success) : super.withName(eventName: "auto_login") {
    value.properties.addBoolProperty("success", success);
  }
}

class SignUpEvent extends AbstractAnalyticsEvent {
  final bool success;

  SignUpEvent(this.success) : super.withName(eventName: "sign_up") {
    value.properties.addBoolProperty("success", success);
  }
}

class ConfirmationCodeEvent extends AbstractAnalyticsEvent {
  final bool success;

  ConfirmationCodeEvent(this.success) : super.withName(eventName: "confirmation_code") {
    value.properties.addBoolProperty("success", success);
  }
}

class SignOutEvent extends AbstractAnalyticsEvent {
  SignOutEvent() : super.withName(eventName: "sign_out");
}

class ChangeAvatarEvent extends AbstractAnalyticsEvent {
  final ImageSource imageSource;

  ChangeAvatarEvent(this.imageSource) : super.withName(eventName: "change_avatar") {
    value.properties.addStringProperty("image_source", imageSource.toString().split('.').last);
  }
}
