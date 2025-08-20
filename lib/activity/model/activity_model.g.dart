// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => ActivityRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
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

ActivityRecord _$ActivityRecordFromJson(Map<String, dynamic> json) =>
    ActivityRecord(
      activityID: json['activityID'] as String?,
      activityTitle: json['activityTitle'] as String?,
      activityDetails: json['activityDetails'] as String?,
      activityDate: json['activityDate'] as String?,
      dayType: json['dayType'] as String?,
      status: json['status'] as String?,
      classID: json['classID'] as String?,
      className: json['className'] as String?,
      empID: json['empID'] as String?,
      branchID: json['branchID'] as String?,
      school_code: json['school_code'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ActivityRecordToJson(ActivityRecord instance) =>
    <String, dynamic>{
      'activityID': instance.activityID,
      'activityTitle': instance.activityTitle,
      'activityDetails': instance.activityDetails,
      'activityDate': instance.activityDate,
      'dayType': instance.dayType,
      'status': instance.status,
      'classID': instance.classID,
      'className': instance.className,
      'empID': instance.empID,
      'branchID': instance.branchID,
      'school_code': instance.school_code,
      'type': instance.type,
    };
