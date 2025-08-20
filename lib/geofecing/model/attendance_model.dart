import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel {
  bool? status;
  String? message;
  List<MonthsRecorde>? school;
  List<AttendanceRecorde>? academics;
  List<AttendanceRecorde>? records;
  List<SummeryRecorde>? setting;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  AttendanceModel({this.status,
    this.message,
    this.school,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.records,
    this.subject_mark});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}

@JsonSerializable()
class MonthsRecorde {
  String? sno;
  String? filter;
  String? text;
  String? month;

  MonthsRecorde({
    this.sno,
    this.filter,
    this.text,
    this.month,
  });

  factory MonthsRecorde.fromJson(Map<String, dynamic> json) =>
      _$MonthsRecordeFromJson(json);

  Map<String, dynamic> toJson() => _$MonthsRecordeToJson(this);
}

@JsonSerializable()
class AttendanceRecorde {
  String? class_id;
  String? sT_ID;
  String? date;
  String? attendance;
  String? sT_Name;
  String? emp_Name;
  String? emp_Code;
  String? attendanceDate;
  String? stid;
  String? date1;
  String? day;
  String? rowNo;
  String? month;

  AttendanceRecorde({
    this.class_id,
    this.sT_ID,
    this.date,
    this.attendance,
    this.sT_Name,
    this.stid,
    this.date1,
    this.day,
    this.rowNo,
    this.month,
  });

  factory AttendanceRecorde.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordeFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRecordeToJson(this);
}

@JsonSerializable()
class SummeryRecorde {
  String? sT_ID;
  String? rolL_No;
  String? sT_Name;
  String? guardianName;
  String? attenadanceMode;
  String? total;
  String? present;
  String? absent;

  SummeryRecorde({
    this.sT_ID,
    this. rolL_No,
    this. sT_Name,
    this. guardianName,
    this. attenadanceMode,
    this. total,
    this. present,
    this. absent,
  });

  factory SummeryRecorde.fromJson(Map<String, dynamic> json) =>
      _$SummeryRecordeFromJson(json);

  Map<String, dynamic> toJson() => _$SummeryRecordeToJson(this);
}
