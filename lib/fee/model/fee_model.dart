import 'package:json_annotation/json_annotation.dart';

part 'fee_model.g.dart';

@JsonSerializable()
class FeeModel {
  bool? status;
  String? message;
  List<FeeRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  FeeModel({
    this.status,
    this.message,
    this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) =>
      _$FeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeeModelToJson(this);
}

@JsonSerializable()
class FeeRecord {
  String? sT_ID;
  String? admnNo;
  String? rollNo;
  String? sT_Name;
  String? guardianName;
  String? sT_Address;
  String? guardianMobile;
  @JsonKey(name: "class")
  String? className;
  String? fee;
  String? trans;
  String? od;
  String? fine;
  String? amt;

  FeeRecord({
    this.sT_ID,
    this.admnNo,
    this.rollNo,
    this.sT_Name,
    this.guardianName,
    this.sT_Address,
    this.guardianMobile,
    this.className,
    this.fee,
    this.trans,
    this.od,
    this.fine,
    this.amt,
  });

  factory FeeRecord.fromJson(Map<String, dynamic> json) =>
      _$FeeRecordFromJson(json);

  Map<String, dynamic> toJson() => _$FeeRecordToJson(this);
}
