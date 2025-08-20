// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodsModel _$PeriodsModelFromJson(Map<String, dynamic> json) => PeriodsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => PeriodsRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$PeriodsModelToJson(PeriodsModel instance) =>
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

PeriodsRecord _$PeriodsRecordFromJson(Map<String, dynamic> json) =>
    PeriodsRecord(
      emP_ID: json['emP_ID'] as String?,
      emp_Code: json['emp_Code'] as String?,
      emp_Name: json['emp_Name'] as String?,
      objPeriodStatusModel: (json['objPeriodStatusModel'] as List<dynamic>?)
          ?.map((e) => ObjPeriodStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeriodsRecordToJson(PeriodsRecord instance) =>
    <String, dynamic>{
      'emP_ID': instance.emP_ID,
      'emp_Code': instance.emp_Code,
      'emp_Name': instance.emp_Name,
      'objPeriodStatusModel': instance.objPeriodStatusModel,
    };

ObjPeriodStatusModel _$ObjPeriodStatusModelFromJson(
        Map<String, dynamic> json) =>
    ObjPeriodStatusModel(
      period: json['period'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ObjPeriodStatusModelToJson(
        ObjPeriodStatusModel instance) =>
    <String, dynamic>{
      'period': instance.period,
      'status': instance.status,
    };
