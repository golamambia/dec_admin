import 'package:json_annotation/json_annotation.dart';

part 'assignment_model.g.dart';

@JsonSerializable()
class AssignmentModel {
  bool? status;
  String? message;
  List<AssignmentRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  AssignmentModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);
}

@JsonSerializable()
class AssignmentRecord  {
  String? assignmentID;
  String? title;
  String? filePath;
  String? classID;
  String? className;
  String? empName;
  String? sT_Name;
  String? note;
  String? admnNo;
  String? uploadDate;
  String? emp_ID;
  String? branchID;
  String? school_code;
  String? type;


  AssignmentRecord(
      {
        this.assignmentID,
        this.title,
        this.filePath,
        this.classID,
        this.className,
        this.empName,
        this.note,
        this.admnNo,
        this.uploadDate,
        this.emp_ID,
        this.branchID,
        this.school_code,
        this.type,
      });

  factory AssignmentRecord.fromJson(Map<String, dynamic> json) =>
  _$AssignmentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentRecordToJson(this);

}
