// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => NoticeModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => NoticeRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
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

NoticeRecord _$NoticeRecordFromJson(Map<String, dynamic> json) => NoticeRecord(
      noticeID: json['noticeID'] as String?,
      noticeTitle: json['noticeTitle'] as String?,
      noticeDetails: json['noticeDetails'] as String?,
      noticeDate: json['noticeDate'] as String?,
      filePath: json['filePath'] as String?,
      status: json['status'] as String?,
      classID: json['classID'] as String?,
      className: json['className'] as String?,
      empID: json['empID'] as String?,
      branchID: json['branchID'] as String?,
      school_code: json['school_code'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$NoticeRecordToJson(NoticeRecord instance) =>
    <String, dynamic>{
      'noticeID': instance.noticeID,
      'noticeTitle': instance.noticeTitle,
      'noticeDetails': instance.noticeDetails,
      'noticeDate': instance.noticeDate,
      'filePath': instance.filePath,
      'status': instance.status,
      'classID': instance.classID,
      'className': instance.className,
      'empID': instance.empID,
      'branchID': instance.branchID,
      'school_code': instance.school_code,
      'type': instance.type,
    };
