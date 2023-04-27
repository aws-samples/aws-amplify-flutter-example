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
    void Function(StorageTransferProgress)? onProgress,
  }) async {
    const uploadOptions = StorageUploadFileOptions(
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
    void Function(StorageTransferProgress)? onProgress,
  }) async {
    const uploadOptions = StorageUploadFileOptions(
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
    required StorageUploadFileOptions uploadOptions,
    String? uuid,
    void Function(StorageTransferProgress)? onProgress,
  }) async {
    uuid = uuid ?? UUID.getUUID();
    final suffix = file.path.split('.').last;
    final fileName = '${categoryToString(category)}/$uuid.$suffix';
    final result = await Amplify.Storage.uploadFile(
      localFile: AWSFile.fromPath(file.path),
      key: fileName,
      onProgress: onProgress,
      options: uploadOptions,
    ).result;
    return result.uploadedItem.key;
  }

  Future<String> getUrl4PublicFile(String fileKey) async {
    return _getUrlForFile(
      fileKey: fileKey,
      accessLevel: StorageAccessLevel.guest,
    );
  }

  Future<String> getUrl4ProtectedFile(String fileKey) async {
    return _getUrlForFile(
      fileKey: fileKey,
      accessLevel: StorageAccessLevel.protected,
    );
  }

  Future<String> getUrl4PrivateFile(String fileKey) async {
    return _getUrlForFile(
      fileKey: fileKey,
      accessLevel: StorageAccessLevel.private,
    );
  }

  Future<String> _getUrlForFile({
    required String fileKey,
    required StorageAccessLevel accessLevel,
    int? expires,
  }) async {
    return StorageUrlCache.instance.getUrl(fileKey, () async {
      final options = StorageGetUrlOptions(
        accessLevel: accessLevel,
        pluginOptions: S3GetUrlPluginOptions(
          expiresIn: expires == null
              ? const Duration(minutes: 15)
              : Duration(seconds: expires),
        ),
      );
      final result =
          await Amplify.Storage.getUrl(key: fileKey, options: options).result;
      return result.url.toString();
    });
  }

  String categoryToString(StorageCategory category) {
    return category.toString().split('.').last;
  }
}
