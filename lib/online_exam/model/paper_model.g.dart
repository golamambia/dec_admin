// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperModel _$PaperModelFromJson(Map<String, dynamic> json) => PaperModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => PaperRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$PaperModelToJson(PaperModel instance) =>
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

PaperRecord _$PaperRecordFromJson(Map<String, dynamic> json) => PaperRecord(
      empID: json['empID'] as String?,
      type: json['type'] as String?,
      actiontype: json['actiontype'] as String?,
      school_code: json['school_code'] as String?,
      branchID: json['branchID'] as String?,
      fileType: json['fileType'] as String?,
      questionID: json['questionID'] as String?,
      examID: json['examID'] as String?,
      classID: json['classID'] as String?,
      subjectID: json['subjectID'] as String?,
      questionType: json['questionType'] as String?,
      question: json['question'] as String?,
      questionFile: json['questionFile'] as String?,
      questionFileData: json['questionFileData'] as String?,
      choice1: json['choice1'] as String?,
      choice1File: json['choice1File'] as String?,
      choice1FileData: json['choice1FileData'] as String?,
      choice2: json['choice2'] as String?,
      choice2File: json['choice2File'] as String?,
      choice2FileData: json['choice2FileData'] as String?,
      choice3: json['choice3'] as String?,
      choice3File: json['choice3File'] as String?,
      choice3FileData: json['choice3FileData'] as String?,
      choice4: json['choice4'] as String?,
      choice4File: json['choice4File'] as String?,
      choice4FileData: json['choice4FileData'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      questionMarks: json['questionMarks'] as String?,
      hints: json['hints'] as String?,
      isActive: json['isActive'] as String?,
      remaining: json['remaining'] as String?,
      isUploaded: json['isUploaded'] as String?,
    );

Map<String, dynamic> _$PaperRecordToJson(PaperRecord instance) =>
    <String, dynamic>{
      'empID': instance.empID,
      'type': instance.type,
      'actiontype': instance.actiontype,
      'school_code': instance.school_code,
      'branchID': instance.branchID,
      'fileType': instance.fileType,
      'questionID': instance.questionID,
      'examID': instance.examID,
      'classID': instance.classID,
      'subjectID': instance.subjectID,
      'questionType': instance.questionType,
      'question': instance.question,
      'questionFile': instance.questionFile,
      'questionFileData': instance.questionFileData,
      'choice1': instance.choice1,
      'choice1File': instance.choice1File,
      'choice1FileData': instance.choice1FileData,
      'choice2': instance.choice2,
      'choice2File': instance.choice2File,
      'choice2FileData': instance.choice2FileData,
      'choice3': instance.choice3,
      'choice3File': instance.choice3File,
      'choice3FileData': instance.choice3FileData,
      'choice4': instance.choice4,
      'choice4File': instance.choice4File,
      'choice4FileData': instance.choice4FileData,
      'correctAnswer': instance.correctAnswer,
      'questionMarks': instance.questionMarks,
      'hints': instance.hints,
      'isActive': instance.isActive,
      'remaining': instance.remaining,
      'isUploaded': instance.isUploaded,
    };
