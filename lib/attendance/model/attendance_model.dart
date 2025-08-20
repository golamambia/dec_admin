import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel {
  bool? status;
  String? message;
  List<AttendanceRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  AttendanceModel(
      {this.status,
      this.message,
      this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}

@JsonSerializable()
class AttendanceRecord {
  String? sT_ID;
  String? rolL_No;
  String? sT_Name;
  String? guardianName;
  @JsonKey(name: "attenadanceMode", fromJson: _attendanceFromType)
  Rx<int>? attenadanceMode;
  String? total;
  String? present;
  String? absent;

  //Emp_Attendance
  String? emP_ID;
  String? emp_Code;
  String? emp_Name;
  String? attendanceDate;
  // List<ObjPeriodStatusModel>? objPeriodStatusModel;

  // String? attenadanceMode;
  // String? total;
  // String? present;
  // String? absent;

  AttendanceRecord({
    this.sT_ID,
    this.rolL_No,
    this.sT_Name,
    this.guardianName,
    this.attenadanceMode,
    this.total,
    this.present,
    this.absent,
    this.emP_ID,
    this.emp_Code,
    this.emp_Name,
    this.attendanceDate,
    // this.objPeriodStatusModel
  });

  static Rx<int>? _attendanceFromType(String type) {
    switch (type) {
      case '1':
        return 1.obs;
        break;
      case '2':
        return 2.obs;
        break;
      case '3':
        return 3.obs;
        break;
      case '4':
        return 4.obs;
        break;
      default:
        return 0.obs;
    }
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRecordToJson(this);
}


@JsonSerializable()
class ObjPeriodStatusModel {

  String? period;
  String? status;

  ObjPeriodStatusModel({
    this.period,
    this.status,
  });



  factory ObjPeriodStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ObjPeriodStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ObjPeriodStatusModelToJson(this);
}
