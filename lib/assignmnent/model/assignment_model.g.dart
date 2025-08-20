// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => AssignmentRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
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

AssignmentRecord _$AssignmentRecordFromJson(Map<String, dynamic> json) =>
    AssignmentRecord(
      assignmentID: json['assignmentID'] as String?,
      title: json['title'] as String?,
      filePath: json['filePath'] as String?,
      classID: json['classID'] as String?,
      className: json['className'] as String?,
      empName: json['empName'] as String?,
      note: json['note'] as String?,
      admnNo: json['admnNo'] as String?,
      uploadDate: json['uploadDate'] as String?,
      emp_ID: json['emp_ID'] as String?,
      branchID: json['branchID'] as String?,
      school_code: json['school_code'] as String?,
      type: json['type'] as String?,
    )..sT_Name = json['sT_Name'] as String?;

Map<String, dynamic> _$AssignmentRecordToJson(AssignmentRecord instance) =>
    <String, dynamic>{
      'assignmentID': instance.assignmentID,
      'title': instance.title,
      'filePath': instance.filePath,
      'classID': instance.classID,
      'className': instance.className,
      'empName': instance.empName,
      'sT_Name': instance.sT_Name,
      'note': instance.note,
      'admnNo': instance.admnNo,
      'uploadDate': instance.uploadDate,
      'emp_ID': instance.emp_ID,
      'branchID': instance.branchID,
      'school_code': instance.school_code,
      'type': instance.type,
    };
