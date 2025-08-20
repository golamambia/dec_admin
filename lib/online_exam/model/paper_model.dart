import 'package:json_annotation/json_annotation.dart';

part 'paper_model.g.dart';

@JsonSerializable()
class PaperModel {
  bool? status;
  String? message;
  List<PaperRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  PaperModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory PaperModel.fromJson(Map<String, dynamic> json) =>
      _$PaperModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaperModelToJson(this);
}

@JsonSerializable()
class PaperRecord {

  String? empID;
  String? type;
  String? actiontype;
  String? school_code;
  String? branchID;
  String? fileType;
  String? questionID;
  String? examID;
  String? classID;
  String? subjectID;
  String? questionType;
  String? question;
  String? questionFile;
  String? questionFileData;
  String? choice1;
  String? choice1File;
  String? choice1FileData;
  String? choice2;
  String? choice2File;
  String? choice2FileData;
  String? choice3;
  String? choice3File;
  String? choice3FileData;
  String? choice4;
  String? choice4File;
  String? choice4FileData;
  String? correctAnswer;
  String? questionMarks;
  String? hints;
  String? isActive;
  String? remaining;
  String? isUploaded;

  PaperRecord(
      {
        this.empID,
        this.type,
        this.actiontype,
        this.school_code,
        this.branchID,
        this.fileType,
        this.questionID,
        this.examID,
        this.classID,
        this.subjectID,
        this.questionType,
        this.question,
        this.questionFile,
        this.questionFileData,
        this.choice1,
        this.choice1File,
        this.choice1FileData,
        this.choice2,
        this.choice2File,
        this.choice2FileData,
        this.choice3,
        this.choice3File,
        this.choice3FileData,
        this.choice4,
        this.choice4File,
        this.choice4FileData,
        this.correctAnswer,
        this.questionMarks,
        this.hints,
        this.isActive,
        this.remaining,
        this.isUploaded
      });

  factory PaperRecord.fromJson(Map<String, dynamic> json) => _$PaperRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PaperRecordToJson(this);
}
