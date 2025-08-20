// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_mark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentMarkModel _$StudentMarkModelFromJson(Map<String, dynamic> json) =>
    StudentMarkModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      setting: (json['setting'] as List<dynamic>?)
          ?.map((e) => SettingRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: (json['school'] as List<dynamic>?)
          ?.map((e) => StudentMarkRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      academics: (json['academics'] as List<dynamic>?)
          ?.map((e) => GradeRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      footer: (json['footer'] as List<dynamic>?)
          ?.map((e) => Footer.fromJson(e as Map<String, dynamic>))
          .toList(),
      profile: json['profile'] as String?,
      schoolProfile: json['schoolProfile'] as String?,
      branchList: json['branchList'] as String?,
      count: json['count'] as String?,
    );

Map<String, dynamic> _$StudentMarkModelToJson(StudentMarkModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'school': instance.school,
      'academics': instance.academics,
      'setting': instance.setting,
      'footer': instance.footer,
      'profile': instance.profile,
      'schoolProfile': instance.schoolProfile,
      'branchList': instance.branchList,
      'count': instance.count,
    };

Footer _$FooterFromJson(Map<String, dynamic> json) => Footer(
      isPersmission: json['isPersmission'] as String?,
    );

Map<String, dynamic> _$FooterToJson(Footer instance) => <String, dynamic>{
      'isPersmission': instance.isPersmission,
    };

StudentMarkRecords _$StudentMarkRecordsFromJson(Map<String, dynamic> json) =>
    StudentMarkRecords(
      sT_ID: json['sT_ID'] as String?,
      rollNo: json['rollNo'] as String?,
      sT_Name: json['sT_Name'] as String?,
      guardianName: json['guardianName'] as String?,
      marks: json['marks'] as String?,
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$StudentMarkRecordsToJson(StudentMarkRecords instance) =>
    <String, dynamic>{
      'sT_ID': instance.sT_ID,
      'rollNo': instance.rollNo,
      'sT_Name': instance.sT_Name,
      'guardianName': instance.guardianName,
      'marks': instance.marks,
      'grade': instance.grade,
    };

GradeRecords _$GradeRecordsFromJson(Map<String, dynamic> json) => GradeRecords(
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$GradeRecordsToJson(GradeRecords instance) =>
    <String, dynamic>{
      'grade': instance.grade,
    };

SettingRecords _$SettingRecordsFromJson(Map<String, dynamic> json) =>
    SettingRecords(
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$SettingRecordsToJson(SettingRecords instance) =>
    <String, dynamic>{
      'grade': instance.grade,
    };
