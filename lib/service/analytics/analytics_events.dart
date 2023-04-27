// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:image_picker/image_picker.dart';

abstract class AbstractAnalyticsEvent {
  AbstractAnalyticsEvent.withName({required String eventName})
      : value = AnalyticsEvent(eventName);

  AbstractAnalyticsEvent.withEvent({required AnalyticsEvent event})
      : value = event;

  final AnalyticsEvent value;
}

class LoginEvent extends AbstractAnalyticsEvent {
  LoginEvent(this.success) : super.withName(eventName: 'login') {
    value.customProperties.addBoolProperty('success', success);
  }

  final bool success;
}

class AutoLoginEvent extends AbstractAnalyticsEvent {
  AutoLoginEvent(this.success) : super.withName(eventName: 'auto_login') {
    value.customProperties.addBoolProperty('success', success);
  }

  final bool success;
}

class SignUpEvent extends AbstractAnalyticsEvent {
  SignUpEvent(this.success) : super.withName(eventName: 'sign_up') {
    value.customProperties.addBoolProperty('success', success);
  }

  final bool success;
}

class ConfirmationCodeEvent extends AbstractAnalyticsEvent {
  ConfirmationCodeEvent(this.success)
      : super.withName(eventName: 'confirmation_code') {
    value.customProperties.addBoolProperty('success', success);
  }

  final bool success;
}

class SignOutEvent extends AbstractAnalyticsEvent {
  SignOutEvent() : super.withName(eventName: 'sign_out');
}

class ChangeAvatarEvent extends AbstractAnalyticsEvent {
  ChangeAvatarEvent(this.imageSource)
      : super.withName(eventName: 'change_avatar') {
    value.customProperties.addStringProperty(
      'image_source',
      imageSource.toString().split('.').last,
    );
  }

  final ImageSource imageSource;
}
