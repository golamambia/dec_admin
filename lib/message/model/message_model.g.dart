// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => MessageRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
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

MessageRecord _$MessageRecordFromJson(Map<String, dynamic> json) =>
    MessageRecord(
      tempid: json['tempid'] as String?,
      messageTitle: json['messageTitle'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessageRecordToJson(MessageRecord instance) =>
    <String, dynamic>{
      'tempid': instance.tempid,
      'messageTitle': instance.messageTitle,
      'message': instance.message,
    };
