// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_cls_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineClsModel _$OnlineClsModelFromJson(Map<String, dynamic> json) =>
    OnlineClsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => OnlineClsRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$OnlineClsModelToJson(OnlineClsModel instance) =>
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

OnlineClsRecord _$OnlineClsRecordFromJson(Map<String, dynamic> json) =>
    OnlineClsRecord(
      onlineClassID: json['onlineClassID'] as String?,
      empName: json['empName'] as String?,
      emP_ID: json['emP_ID'] as String?,
      classDate: json['classDate'] as String?,
      classTime: json['classTime'] as String?,
      title: json['title'] as String?,
      classLink: json['classLink'] as String?,
      classID: json['classID'] as String?,
      status: json['status'] as String?,
      className: json['className'] as String?,
      branchID: json['branchID'] as String?,
      empID: json['empID'] as String?,
      school_code: json['school_code'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$OnlineClsRecordToJson(OnlineClsRecord instance) =>
    <String, dynamic>{
      'onlineClassID': instance.onlineClassID,
      'empName': instance.empName,
      'emP_ID': instance.emP_ID,
      'classDate': instance.classDate,
      'classTime': instance.classTime,
      'title': instance.title,
      'classLink': instance.classLink,
      'classID': instance.classID,
      'status': instance.status,
      'className': instance.className,
      'branchID': instance.branchID,
      'empID': instance.empID,
      'school_code': instance.school_code,
      'type': instance.type,
    };
