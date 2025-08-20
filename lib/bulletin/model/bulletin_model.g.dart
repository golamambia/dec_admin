// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulletin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulletinModel _$BulletinModelFromJson(Map<String, dynamic> json) =>
    BulletinModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: json['records'] as String?,
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$BulletinModelToJson(BulletinModel instance) =>
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
