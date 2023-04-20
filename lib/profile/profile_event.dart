// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ChangeAvatarRequest extends ProfileEvent {
  const ChangeAvatarRequest();
}

class OpenImagePicker extends ProfileEvent {
  const OpenImagePicker({required this.imageSource});

  final ImageSource imageSource;
}

class ProvideImagePath extends ProfileEvent {
  const ProvideImagePath({required this.avatarPath});

  final String avatarPath;
}
