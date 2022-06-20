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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? username;
  final String? email;
  final String? avatarKey;
  final String? description;
  final String? deviceId;
  final List<OCRRecord>? OCRRecords;
  final TemporalDateTime? createdAt;
  final TemporalDateTime? updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const User._internal(
      {required this.id,
        this.username,
        this.email,
        this.avatarKey,
        this.description,
        this.deviceId,
        this.OCRRecords,
        this.createdAt,
        this.updatedAt});

  factory User(
      {String? id,
        String? username,
        String? email,
        String? avatarKey,
        String? description,
        String? deviceId,
        List<OCRRecord>? OCRRecords}) {
    return User._internal(
        id: id == null ? UUID.getUUID() : id,
        username: username,
        email: email,
        avatarKey: avatarKey,
        description: description,
        deviceId: deviceId,
        OCRRecords: OCRRecords != null ? List<OCRRecord>.unmodifiable(OCRRecords) : OCRRecords);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        avatarKey == other.avatarKey &&
        description == other.description &&
        deviceId == other.deviceId &&
        DeepCollectionEquality().equals(OCRRecords, other.OCRRecords);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$username" + ", ");
    buffer.write("email=" + "$email" + ", ");
    buffer.write("avatarKey=" + "$avatarKey" + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("deviceId=" + "$deviceId" + ", ");
    buffer.write("createdAt=" + (createdAt != null ? createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (updatedAt != null ? updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  User copyWith(
      {String? id,
        String? username,
        String? email,
        String? avatarKey,
        String? description,
        String? deviceId,
        List<OCRRecord>? OCRRecords}) {
    return User._internal(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        avatarKey: avatarKey ?? this.avatarKey,
        description: description ?? this.description,
        deviceId: deviceId ?? this.deviceId,
        OCRRecords: OCRRecords ?? this.OCRRecords);
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        avatarKey = json['avatarKey'],
        description = json['description'],
        deviceId = json['deviceId'],
        OCRRecords = json['OCRRecords'] is List
            ? (json['OCRRecords'] as List).map((e) => OCRRecord.fromJson(new Map<String, dynamic>.from(e))).toList()
            : null,
        createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
        updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'avatarKey': avatarKey,
    'description': description,
    'deviceId': deviceId,
    'OCRRecords': OCRRecords?.map((OCRRecord e) => e.toJson()).toList(),
    'createdAt': createdAt?.format(),
    'updatedAt': updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField AVATARKEY = QueryField(fieldName: "avatarKey");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField DEVICEID = QueryField(fieldName: "deviceId");
  static final QueryField OCRRECORDS = QueryField(
      fieldName: "OCRRecords",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (OCRRecord).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.USERNAME, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.EMAIL, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.AVATARKEY, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DESCRIPTION, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DEVICEID, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.OCRRECORDS, isRequired: false, ofModelName: (OCRRecord).toString(), associatedKey: OCRRecord.USERID));

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

class _UserModelType extends ModelType<User> {
  const _UserModelType();

  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}
