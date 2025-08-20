import 'package:json_annotation/json_annotation.dart';

part 'online_cls_model.g.dart';

@JsonSerializable()
class OnlineClsModel {
  bool? status;
  String? message;
  List<OnlineClsRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  OnlineClsModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory OnlineClsModel.fromJson(Map<String, dynamic> json) =>
      _$OnlineClsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineClsModelToJson(this);
}

@JsonSerializable()
class OnlineClsRecord  {
  String? onlineClassID;
  String? empName;
  String? emP_ID;
  String? classDate;
  String? classTime;
  String? title;
  String? classLink;
  String? classID;
  String? status;
  String? className;
  String? branchID;
  String? empID;
  String? school_code;
  String? type;


  OnlineClsRecord(
      {
        this.onlineClassID,
      this.empName,
      this.emP_ID,
      this.classDate,
      this.classTime,
      this.title,
      this.classLink,
      this.classID,
      this.status,
      this.className,
      this.branchID,
      this.empID,
      this.school_code,
      this.type,
      });

  factory OnlineClsRecord.fromJson(Map<String, dynamic> json) =>
  _$OnlineClsRecordFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineClsRecordToJson(this);

}
