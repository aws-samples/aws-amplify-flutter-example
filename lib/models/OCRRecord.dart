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
  final String? _fullKey;
  final String? _privateKey;
  final String? _content;
  final String? _userID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  OCRRecordModelIdentifier get modelIdentifier {
      return OCRRecordModelIdentifier(
        id: id
      );
  }
  
  String? get fullKey {
    return _fullKey;
  }
  
  String? get privateKey {
    return _privateKey;
  }
  
  String? get content {
    return _content;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const OCRRecord._internal({required this.id, fullKey, privateKey, content, required userID, createdAt, updatedAt}): _fullKey = fullKey, _privateKey = privateKey, _content = content, _userID = userID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory OCRRecord({String? id, String? fullKey, String? privateKey, String? content, required String userID}) {
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
      _fullKey == other._fullKey &&
      _privateKey == other._privateKey &&
      _content == other._content &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("OCRRecord {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("fullKey=" + "$_fullKey" + ", ");
    buffer.write("privateKey=" + "$_privateKey" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  OCRRecord copyWith({String? fullKey, String? privateKey, String? content, String? userID}) {
    return OCRRecord._internal(
      id: id,
      fullKey: fullKey ?? this.fullKey,
      privateKey: privateKey ?? this.privateKey,
      content: content ?? this.content,
      userID: userID ?? this.userID);
  }
  
  OCRRecord.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _fullKey = json['fullKey'],
      _privateKey = json['privateKey'],
      _content = json['content'],
      _userID = json['userID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'fullKey': _fullKey, 'privateKey': _privateKey, 'content': _content, 'userID': _userID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'fullKey': _fullKey, 'privateKey': _privateKey, 'content': _content, 'userID': _userID, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<OCRRecordModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<OCRRecordModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField FULLKEY = QueryField(fieldName: "fullKey");
  static final QueryField PRIVATEKEY = QueryField(fieldName: "privateKey");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "OCRRecord";
    modelSchemaDefinition.pluralName = "OCRRecords";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: OCRRecord.FULLKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: OCRRecord.PRIVATEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: OCRRecord.CONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: OCRRecord.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _OCRRecordModelType extends ModelType<OCRRecord> {
  const _OCRRecordModelType();
  
  @override
  OCRRecord fromJson(Map<String, dynamic> jsonData) {
    return OCRRecord.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'OCRRecord';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [OCRRecord] in your schema.
 */
@immutable
class OCRRecordModelIdentifier implements ModelIdentifier<OCRRecord> {
  final String id;

  /** Create an instance of OCRRecordModelIdentifier using [id] the primary key. */
  const OCRRecordModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'OCRRecordModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is OCRRecordModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}