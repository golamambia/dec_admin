import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  bool? status;
  String? message;
  List<ActivityRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  ActivityModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}

@JsonSerializable()
class ActivityRecord  {
  String? activityID;
  String? activityTitle;
  String? activityDetails;
  String? activityDate;
  String? dayType;
  String? status;
  String? classID;
  String? className;
  String? empID;
  String? branchID;
  String? school_code;
  String? type;


  ActivityRecord(
      {this.activityID,
      this.activityTitle,
      this.activityDetails,
      this.activityDate,
      this.dayType,
      this.status,
      this.classID,
      this.className,
      this.empID,
      this.branchID,
      this.school_code,
      this.type});

  factory ActivityRecord.fromJson(Map<String, dynamic> json) =>
  _$ActivityRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRecordToJson(this);

}
