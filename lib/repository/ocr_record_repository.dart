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
    final request = requestForNextResult ??
        ModelQueries.list(
          OCRRecord.classType,
          limit: 30,
          // where: OCRRecord.USERID.eq(userId),
        );
    final response = await Amplify.API.query(request: request).response;
    return response.data;
  }

  Future<OCRRecord?> getOCRRecordById(String id) async {
    final request = ModelQueries.get(
      OCRRecord.classType,
      OCRRecordModelIdentifier(id: id),
    );
    final response = await Amplify.API.query(request: request).response;
    return response.data;
  }

  Future<OCRRecord> saveOCRRecord(OCRRecord ocrRecord) async {
    final request = ModelMutations.create(ocrRecord);
    final response = await Amplify.API.mutate(request: request).response;
    return response.data!;
  }
}
