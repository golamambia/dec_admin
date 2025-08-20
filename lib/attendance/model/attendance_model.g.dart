// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
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

AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) =>
    AttendanceRecord(
      sT_ID: json['sT_ID'] as String?,
      rolL_No: json['rolL_No'] as String?,
      sT_Name: json['sT_Name'] as String?,
      guardianName: json['guardianName'] as String?,
      attenadanceMode: AttendanceRecord._attendanceFromType(
          json['attenadanceMode'] as String),
      total: json['total'] as String?,
      present: json['present'] as String?,
      absent: json['absent'] as String?,
      emP_ID: json['emP_ID'] as String?,
      emp_Code: json['emp_Code'] as String?,
      emp_Name: json['emp_Name'] as String?,
      attendanceDate: json['attendanceDate'] as String?,
    );

Map<String, dynamic> _$AttendanceRecordToJson(AttendanceRecord instance) =>
    <String, dynamic>{
      'sT_ID': instance.sT_ID,
      'rolL_No': instance.rolL_No,
      'sT_Name': instance.sT_Name,
      'guardianName': instance.guardianName,
      'attenadanceMode': instance.attenadanceMode,
      'total': instance.total,
      'present': instance.present,
      'absent': instance.absent,
      'emP_ID': instance.emP_ID,
      'emp_Code': instance.emp_Code,
      'emp_Name': instance.emp_Name,
      'attendanceDate': instance.attendanceDate,
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
