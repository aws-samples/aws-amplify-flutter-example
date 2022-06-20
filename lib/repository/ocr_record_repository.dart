// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '/models/OCRRecord.dart';

class OCRRecordRepository {
  Future<PaginatedResult<OCRRecord>?> queryOCRRecordsOfUser({
    required String userId,
    GraphQLRequest<PaginatedResult<OCRRecord>>? requestForNextResult,
  }) async {
    try {
      var request = requestForNextResult ??
          ModelQueries.list(
            OCRRecord.classType,
            limit: 30,
            // where: OCRRecord.USERID.eq(userId),
          );
      final response = await Amplify.API.query(request: request).response;
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<OCRRecord?> getOCRRecordById(String id) async {
    try {
      final request = ModelQueries.get(OCRRecord.classType, id);
      final response = await Amplify.API.query(request: request).response;
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<OCRRecord> saveOCRRecord(OCRRecord ocrRecord) async {
    try {
      final request = ModelMutations.create(ocrRecord);
      final response = await Amplify.API.mutate(request: request).response;
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
}
