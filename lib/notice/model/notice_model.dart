import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class NoticeModel {
  bool? status;
  String? message;
  List<NoticeRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  NoticeModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}

@JsonSerializable()
class NoticeRecord  {
  String? noticeID;
  String? noticeTitle;
  String? noticeDetails;
  String? noticeDate;
  String? filePath;
  String? status;
  String? classID;
  String? className;
  String? empID;
  String? branchID;
  String? school_code;
  String? type;


  NoticeRecord(
      {this.noticeID,
      this.noticeTitle,
      this.noticeDetails,
      this.noticeDate,
      this.filePath,
      this.status,
      this.classID,
      this.className,
      this.empID,
      this.branchID,
      this.school_code,
      this.type});

  factory NoticeRecord.fromJson(Map<String, dynamic> json) =>
  _$NoticeRecordFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeRecordToJson(this);

}
