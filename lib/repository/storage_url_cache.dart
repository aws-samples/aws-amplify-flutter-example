// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

class StorageUrlCache {
  StorageUrlCache._privateConstructor();

  static final StorageUrlCache _instance = StorageUrlCache._privateConstructor();

  static StorageUrlCache get instance => _instance;

  final Map<String, String> _urlCache = {};

  Future<String> getUrl(String imageKey, Function getUrl) async {
    String? url = _urlCache[imageKey];

    if (url == null) {
      try {
        url = await getUrl();
        _urlCache[imageKey] = url!;
      } catch (e) {
        rethrow;
      }
    }
    return url;
  }
}
