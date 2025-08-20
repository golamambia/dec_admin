// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      school: (json['school'] as List<dynamic>?)
          ?.map((e) => MonthsRecorde.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => AttendanceRecorde.fromJson(e as Map<String, dynamic>))
          .toList(),
      subject_mark: json['subject_mark'] as String?,
    )
      ..academics = (json['academics'] as List<dynamic>?)
          ?.map((e) => AttendanceRecorde.fromJson(e as Map<String, dynamic>))
          .toList()
      ..setting = (json['setting'] as List<dynamic>?)
          ?.map((e) => SummeryRecorde.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'school': instance.school,
      'academics': instance.academics,
      'records': instance.records,
      'setting': instance.setting,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

MonthsRecorde _$MonthsRecordeFromJson(Map<String, dynamic> json) =>
    MonthsRecorde(
      sno: json['sno'] as String?,
      filter: json['filter'] as String?,
      text: json['text'] as String?,
      month: json['month'] as String?,
    );

Map<String, dynamic> _$MonthsRecordeToJson(MonthsRecorde instance) =>
    <String, dynamic>{
      'sno': instance.sno,
      'filter': instance.filter,
      'text': instance.text,
      'month': instance.month,
    };

AttendanceRecorde _$AttendanceRecordeFromJson(Map<String, dynamic> json) =>
    AttendanceRecorde(
      class_id: json['class_id'] as String?,
      sT_ID: json['sT_ID'] as String?,
      date: json['date'] as String?,
      attendance: json['attendance'] as String?,
      sT_Name: json['sT_Name'] as String?,
      stid: json['stid'] as String?,
      date1: json['date1'] as String?,
      day: json['day'] as String?,
      rowNo: json['rowNo'] as String?,
      month: json['month'] as String?,
    )
      ..emp_Name = json['emp_Name'] as String?
      ..emp_Code = json['emp_Code'] as String?
      ..attendanceDate = json['attendanceDate'] as String?;

Map<String, dynamic> _$AttendanceRecordeToJson(AttendanceRecorde instance) =>
    <String, dynamic>{
      'class_id': instance.class_id,
      'sT_ID': instance.sT_ID,
      'date': instance.date,
      'attendance': instance.attendance,
      'sT_Name': instance.sT_Name,
      'emp_Name': instance.emp_Name,
      'emp_Code': instance.emp_Code,
      'attendanceDate': instance.attendanceDate,
      'stid': instance.stid,
      'date1': instance.date1,
      'day': instance.day,
      'rowNo': instance.rowNo,
      'month': instance.month,
    };

SummeryRecorde _$SummeryRecordeFromJson(Map<String, dynamic> json) =>
    SummeryRecorde(
      sT_ID: json['sT_ID'] as String?,
      rolL_No: json['rolL_No'] as String?,
      sT_Name: json['sT_Name'] as String?,
      guardianName: json['guardianName'] as String?,
      attenadanceMode: json['attenadanceMode'] as String?,
      total: json['total'] as String?,
      present: json['present'] as String?,
      absent: json['absent'] as String?,
    );

Map<String, dynamic> _$SummeryRecordeToJson(SummeryRecorde instance) =>
    <String, dynamic>{
      'sT_ID': instance.sT_ID,
      'rolL_No': instance.rolL_No,
      'sT_Name': instance.sT_Name,
      'guardianName': instance.guardianName,
      'attenadanceMode': instance.attenadanceMode,
      'total': instance.total,
      'present': instance.present,
      'absent': instance.absent,
    };
