import 'package:json_annotation/json_annotation.dart';

part 'home_work_model.g.dart';

@JsonSerializable()
class HomeWorkModel {
  bool? status;
  String? message;
  List<HomeWorkRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  HomeWorkModel(
      {this.status,
      this.message,
      this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark});

  factory HomeWorkModel.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkModelToJson(this);
}

@JsonSerializable()
class HomeWorkRecord {
  String? homeworkID;
  String? postMode;
  String? postData;
  String? filePath;
  String? empName;
  String? emp_ID;
  String? classID;
  String? className;
  String? empID;
  String? branchID;
  String? school_code;
  String? type;
  String? uploadDate;
  String? note;
  String? sT_Name;
  String? admnNo;

  HomeWorkRecord(
      {this.homeworkID,
      this.postMode,
      this.postData,
      this.filePath,
      this.empName,
      this.emp_ID,
      this.classID,
      this.className,
      this.empID,
      this.branchID,
      this.school_code,
      this.uploadDate,
      this.note,
      this.sT_Name,
      this.admnNo});

  factory HomeWorkRecord.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkRecordFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkRecordToJson(this);
}
