// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => NotificationRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
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

NotificationRecord _$NotificationRecordFromJson(Map<String, dynamic> json) =>
    NotificationRecord(
      title: json['title'] as String?,
      msgBody: json['msgBody'] as String?,
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$NotificationRecordToJson(NotificationRecord instance) =>
    <String, dynamic>{
      'title': instance.title,
      'msgBody': instance.msgBody,
      'createdDate': instance.createdDate,
    };
