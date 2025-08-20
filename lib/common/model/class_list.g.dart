// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassList _$ClassListFromJson(Map<String, dynamic> json) => ClassList(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => ClassRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$ClassListToJson(ClassList instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'records': instance.records,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

ClassRecord _$ClassRecordFromJson(Map<String, dynamic> json) => ClassRecord(
      classID: json['classID'] as String?,
      className: json['className'] as String?,
      classSection: json['classSection'] as String?,
      classsStandard: json['classsStandard'] as String?,
      recessPeriod: json['recessPeriod'] as String?,
      totalPeriodDay: json['totalPeriodDay'] as String?,
      workDays: json['workDays'] as String?,
      actualPeriodWeek: json['actualPeriodWeek'] as String?,
      ddlClassName: json['ddlClassName'] as String?,
    );

Map<String, dynamic> _$ClassRecordToJson(ClassRecord instance) =>
    <String, dynamic>{
      'classID': instance.classID,
      'className': instance.className,
      'classSection': instance.classSection,
      'classsStandard': instance.classsStandard,
      'recessPeriod': instance.recessPeriod,
      'totalPeriodDay': instance.totalPeriodDay,
      'workDays': instance.workDays,
      'actualPeriodWeek': instance.actualPeriodWeek,
      'ddlClassName': instance.ddlClassName,
    };
