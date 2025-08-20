import 'package:json_annotation/json_annotation.dart';

part 'installment_model.g.dart';

@JsonSerializable()
class InstallmentModel {
  bool? status;
  String? message;
  List<InstallmentRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  InstallmentModel({
    this.status,
    this.message,
    required this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory InstallmentModel.fromJson(Map<String, dynamic> json) =>
      _$InstallmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstallmentModelToJson(this);
}


@JsonSerializable()
class InstallmentRecord {
  String? installmentID;
  String? sessionID;
  String? slNo;
  String? insT_Name;
  String? insT_Due_Date;
  String? insT_Limit_Date;
  String? installmentMappID;
  String? monthID;
  String? monthName;
  String? receiptDate;

  InstallmentRecord({
    this.installmentID,
    this.sessionID,
    this.slNo,
    this.insT_Name,
    this.insT_Due_Date,
    this.insT_Limit_Date,
    this.installmentMappID,
    this.monthID,
    this.monthName,
    this.receiptDate,
  });

  factory InstallmentRecord.fromJson(Map<String, dynamic> json) =>
      _$InstallmentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$InstallmentRecordToJson(this);
}