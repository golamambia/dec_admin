import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'periods_model.g.dart';

@JsonSerializable()
class PeriodsModel {
  bool? status;
  String? message;
  List<PeriodsRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  PeriodsModel(
      {this.status,
      this.message,
      this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark});

  factory PeriodsModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodsModelToJson(this);
}

@JsonSerializable()
class PeriodsRecord {

  String? emP_ID;
  String? emp_Code;
  String? emp_Name;
  List<ObjPeriodStatusModel>? objPeriodStatusModel;

  // String? attenadanceMode;
  // String? total;
  // String? present;
  // String? absent;

  PeriodsRecord({

    this.emP_ID,
    this.emp_Code,
    this.emp_Name,
    this.objPeriodStatusModel
  });



  factory PeriodsRecord.fromJson(Map<String, dynamic> json) =>
      _$PeriodsRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodsRecordToJson(this);
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
