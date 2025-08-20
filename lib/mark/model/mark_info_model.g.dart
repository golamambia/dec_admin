// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkInfoModel _$MarkInfoModelFromJson(Map<String, dynamic> json) =>
    MarkInfoModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => InfoRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$MarkInfoModelToJson(MarkInfoModel instance) =>
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

InfoRecords _$InfoRecordsFromJson(Map<String, dynamic> json) => InfoRecords(
      examID: json['examID'] as String?,
      examName: json['examName'] as String?,
      maxMarks: json['maxMarks'] as String?,
      subjectID: json['subjectID'] as String?,
      subjectName: json['subjectName'] as String?,
    );

Map<String, dynamic> _$InfoRecordsToJson(InfoRecords instance) =>
    <String, dynamic>{
      'examID': instance.examID,
      'examName': instance.examName,
      'maxMarks': instance.maxMarks,
      'subjectID': instance.subjectID,
      'subjectName': instance.subjectName,
    };
