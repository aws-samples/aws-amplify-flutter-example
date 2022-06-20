// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {
  final ImageSource imageSource;

  OpenImagePicker({required this.imageSource});
}

class ProvideImagePath extends ProfileEvent {
  final String avatarPath;

  ProvideImagePath({required this.avatarPath});
}