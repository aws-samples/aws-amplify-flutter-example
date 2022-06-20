/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the OCRRecord type in your schema. */
@immutable
class OCRRecord extends Model {
  static const classType = const _OCRRecordModelType();
  final String id;
  final String? fullKey;
  final String? privateKey;
  final String? content;
  final String userID;
  final TemporalDateTime? createdAt;
  final TemporalDateTime? updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const OCRRecord._internal(
      {required this.id,
        this.fullKey,
        this.privateKey,
        this.content,
        required this.userID,
        this.createdAt,
        this.updatedAt});

  factory OCRRecord(
      {String? id,
        String? fullKey,
        String? privateKey,
        String? content,
        required String userID}) {
    return OCRRecord._internal(
        id: id == null ? UUID.getUUID() : id,
        fullKey: fullKey,
        privateKey: privateKey,
        content: content,
        userID: userID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OCRRecord &&
        id == other.id &&
        fullKey == other.fullKey &&
        privateKey == other.privateKey &&
        content == other.content &&
        userID == other.userID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("OCRRecord {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("fullKey=" + "$fullKey" + ", ");
    buffer.write("privateKey=" + "$privateKey" + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write("userID=" + "$userID" + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (updatedAt != null ? updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  OCRRecord copyWith(
      {String? id,
        String? fullKey,
        String? privateKey,
        String? content,
        String? userID}) {
    return OCRRecord._internal(
        id: id ?? this.id,
        fullKey: fullKey ?? this.fullKey,
        privateKey: privateKey ?? this.privateKey,
        content: content ?? this.content,
        userID: userID ?? this.userID);
  }

  OCRRecord.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullKey = json['fullKey'],
        privateKey = json['privateKey'],
        content = json['content'],
        userID = json['userID'],
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullKey': fullKey,
    'privateKey': privateKey,
    'content': content,
    'userID': userID,
    'createdAt': createdAt?.format(),
    'updatedAt': updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "oCRRecord.id");
  static final QueryField FULLKEY = QueryField(fieldName: "fullKey");
  static final QueryField PRIVATEKEY = QueryField(fieldName: "privateKey");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema =
  Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "OCRRecord";
    modelSchemaDefinition.pluralName = "OCRRecords";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PRIVATE, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: OCRRecord.FULLKEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: OCRRecord.PRIVATEKEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: OCRRecord.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: OCRRecord.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _OCRRecordModelType extends ModelType<OCRRecord> {
  const _OCRRecordModelType();

  @override
  OCRRecord fromJson(Map<String, dynamic> jsonData) {
    return OCRRecord.fromJson(jsonData);
  }
}
