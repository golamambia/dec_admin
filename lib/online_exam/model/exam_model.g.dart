// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => ExamModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => ExamRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$ExamModelToJson(ExamModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'records': instance.records,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

ExamRecords _$ExamRecordsFromJson(Map<String, dynamic> json) => ExamRecords(
      empID: json['empID'] as String?,
      onlineExamClassSubjectMappID:
          json['onlineExamClassSubjectMappID'] as String?,
      type: json['type'] as String?,
      school_code: json['school_code'] as String?,
      branchID: json['branchID'] as String?,
      questionID: json['questionID'] as String?,
      examID: json['examID'] as String?,
      exam: json['exam'] as String?,
      examDate: json['examDate'] as String?,
      examDateFrom: json['examDateFrom'] as String?,
      examDateTo: json['examDateTo'] as String?,
      yrID: json['yrID'] as String?,
      classID: json['classID'] as String?,
      className: json['className'] as String?,
      subjectID: json['subjectID'] as String?,
      subjectName: json['subjectName'] as String?,
      timeIn: json['timeIn'] as String?,
      timeOut: json['timeOut'] as String?,
      duration: json['duration'] as String?,
      objQuesNo: json['objQuesNo'] as String?,
      objQuesMarks: json['objQuesMarks'] as String?,
      desQuesNo: json['desQuesNo'] as String?,
      desQuesMarks: json['desQuesMarks'] as String?,
      maxMarks: json['maxMarks'] as String?,
      passMarks: json['passMarks'] as String?,
      isActive: json['isActive'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      questionType: json['questionType'] as String?,
      clasS_STD: json['clasS_STD'] as String?,
      clasS_NAME: json['clasS_NAME'] as String?,
      isUploadedObj: json['isUploadedObj'] as String?,
      isUploadedDes: json['isUploadedDes'] as String?,
      isResult: json['isResult'] as String?,
      score: json['score'] as String?,
      status: json['status'] as String?,
      suB_NAME: json['suB_NAME'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$ExamRecordsToJson(ExamRecords instance) =>
    <String, dynamic>{
      'empID': instance.empID,
      'onlineExamClassSubjectMappID': instance.onlineExamClassSubjectMappID,
      'type': instance.type,
      'school_code': instance.school_code,
      'branchID': instance.branchID,
      'questionID': instance.questionID,
      'examID': instance.examID,
      'exam': instance.exam,
      'examDate': instance.examDate,
      'examDateFrom': instance.examDateFrom,
      'examDateTo': instance.examDateTo,
      'yrID': instance.yrID,
      'classID': instance.classID,
      'className': instance.className,
      'subjectID': instance.subjectID,
      'subjectName': instance.subjectName,
      'timeIn': instance.timeIn,
      'timeOut': instance.timeOut,
      'duration': instance.duration,
      'objQuesNo': instance.objQuesNo,
      'objQuesMarks': instance.objQuesMarks,
      'desQuesNo': instance.desQuesNo,
      'desQuesMarks': instance.desQuesMarks,
      'maxMarks': instance.maxMarks,
      'passMarks': instance.passMarks,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'questionType': instance.questionType,
      'clasS_STD': instance.clasS_STD,
      'clasS_NAME': instance.clasS_NAME,
      'isUploadedObj': instance.isUploadedObj,
      'isUploadedDes': instance.isUploadedDes,
      'isResult': instance.isResult,
      'score': instance.score,
      'status': instance.status,
      'suB_NAME': instance.suB_NAME,
      'deviceId': instance.deviceId,
    };
