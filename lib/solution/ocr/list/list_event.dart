// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:image_picker/image_picker.dart';

abstract class OCRListEvent {
  const OCRListEvent();
}

class OCRListRefreshEvent extends OCRListEvent {
  const OCRListRefreshEvent();
}

class OCRListLoadingMoreEvent extends OCRListEvent {
  const OCRListLoadingMoreEvent();
}

class UploadImageRequest extends OCRListEvent {
  const UploadImageRequest();
}

class OpenImagePicker extends OCRListEvent {
  const OpenImagePicker({required this.imageSource});

  final ImageSource imageSource;
}
