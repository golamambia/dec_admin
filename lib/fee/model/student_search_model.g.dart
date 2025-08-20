// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentSearchModel _$StudentSearchModelFromJson(Map<String, dynamic> json) =>
    StudentSearchModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => StudentSearchRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$StudentSearchModelToJson(StudentSearchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'records': instance.records,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

StudentSearchRecord _$StudentSearchRecordFromJson(Map<String, dynamic> json) =>
    StudentSearchRecord(
      label: json['value'] as String?,
      value: json['sT_ID'] as String?,
    );

Map<String, dynamic> _$StudentSearchRecordToJson(
        StudentSearchRecord instance) =>
    <String, dynamic>{
      'value': instance.label,
      'sT_ID': instance.value,
    };
