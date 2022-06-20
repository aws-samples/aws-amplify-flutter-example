// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:image_picker/image_picker.dart';

abstract class OCRListEvent {}

class OCRListRefreshEvent extends OCRListEvent {}

class OCRListLoadingMoreEvent extends OCRListEvent {}

class UploadImageRequest extends OCRListEvent {}

class OpenImagePicker extends OCRListEvent {
  final ImageSource imageSource;

  OpenImagePicker({required this.imageSource});
}
