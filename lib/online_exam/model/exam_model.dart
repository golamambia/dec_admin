import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class ExamModel {
  bool? status;
  String? message;
  List<ExamRecords>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  ExamModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}

@JsonSerializable()
class ExamRecords {
  String? empID;
  String? onlineExamClassSubjectMappID;
  String? type;
  String? school_code;
  String? branchID;
  String? questionID;
  String? examID;
  String? exam;
  String? examDate;
  String? examDateFrom;
  String? examDateTo;
  String? yrID;
  String? classID;
  String? className;
  String? subjectID;
  String? subjectName;
  String? timeIn;
  String? timeOut;
  String? duration;
  String? objQuesNo;
  String? objQuesMarks;
  String? desQuesNo;
  String? desQuesMarks;
  String? maxMarks;
  String? passMarks;
  String? isActive;
  String? createdDate;
  String? createdBy;
  String? questionType;
  String? clasS_STD;
  String? clasS_NAME;
  String? isUploadedObj;
  String? isUploadedDes;
  String? isResult;
  String? score;
  String? status;
  String? suB_NAME;
  String? deviceId;

  ExamRecords(
      {
        this.empID,
        this.onlineExamClassSubjectMappID,
        this.type,
        this.school_code,
        this.branchID,
        this.questionID,
        this.examID,
        this.exam,
        this.examDate,
        this.examDateFrom,
        this.examDateTo,
        this.yrID,
        this.classID,
        this.className,
        this.subjectID,
        this.subjectName,
        this.timeIn,
        this.timeOut,
        this.duration,
        this.objQuesNo,
        this.objQuesMarks,
        this.desQuesNo,
        this.desQuesMarks,
        this.maxMarks,
        this.passMarks,
        this.isActive,
        this.createdDate,
        this.createdBy,
        this.questionType,
        this.clasS_STD,
        this.clasS_NAME,
        this.isUploadedObj,
        this.isUploadedDes,
        this.isResult,
        this.score,
        this.status,
        this.suB_NAME,
        this.deviceId,
      });

  factory ExamRecords.fromJson(Map<String, dynamic> json) => _$ExamRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$ExamRecordsToJson(this);
}
