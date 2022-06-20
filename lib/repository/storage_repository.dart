// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import '/repository/storage_url_cache.dart';

enum StorageCategory { avatar, ocrImage }

class StorageRepository {
  Future<String> uploadPrivateFile({
    required StorageCategory category,
    required File file,
    String? uuid,
    void Function(TransferProgress)? onProgress,
  }) async {
    final uploadOptions = S3UploadFileOptions(
      accessLevel: StorageAccessLevel.private,
    );
    return _uploadFile(
      category: category,
      file: file,
      uuid: uuid,
      uploadOptions: uploadOptions,
    );
  }

  Future<String> uploadPublicFile({
    required StorageCategory category,
    required File file,
    String? uuid,
    void Function(TransferProgress)? onProgress,
  }) async {
    final uploadOptions = S3UploadFileOptions(
      accessLevel: StorageAccessLevel.guest,
    );
    return _uploadFile(
      category: category,
      file: file,
      uuid: uuid,
      uploadOptions: uploadOptions,
    );
  }

  Future<String> _uploadFile({
    required StorageCategory category,
    required File file,
    required UploadFileOptions uploadOptions,
    String? uuid,
    void Function(TransferProgress)? onProgress,
  }) async {
    try {
      uuid = uuid ?? UUID.getUUID();
      final suffix = file.path.split('.').last;
      final fileName = categoryToString(category) + "/" + uuid + "." + suffix;
      final result = await Amplify.Storage.uploadFile(
        local: file,
        key: fileName,
        onProgress: onProgress,
        options: uploadOptions,
      );
      return result.key;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUrl4PublicFile(String fileKey) async {
    return await _getUrlForFile(fileKey: fileKey, accessLevel: StorageAccessLevel.guest);
  }

  Future<String> getUrl4ProtectedFile(String fileKey) async {
    return await _getUrlForFile(fileKey: fileKey, accessLevel: StorageAccessLevel.protected);
  }

  Future<String> getUrl4PrivateFile(String fileKey) async {
    return await _getUrlForFile(fileKey: fileKey, accessLevel: StorageAccessLevel.private);
  }

  Future<String> _getUrlForFile({
    required String fileKey,
    required StorageAccessLevel accessLevel,
    int? expires,
  }) async {
    try {
      return StorageUrlCache.instance.getUrl(fileKey, () async {
        final options = GetUrlOptions(
          accessLevel: accessLevel,
          expires: expires,
        );
        final result = await Amplify.Storage.getUrl(key: fileKey, options: options);
        return result.url;
      });
    } catch (e) {
      rethrow;
    }
  }

  String categoryToString(StorageCategory category) {
    return category.toString().split('.').last;
  }
}
