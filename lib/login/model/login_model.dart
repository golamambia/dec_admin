
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {

  bool ? status;
  String ? message;
  Records?  records;
  String ? commondata;
  String ? formStatus;
  String ? sub_type;
  String ? grades;
  String? subject_mark;

  LoginModel({
      this.status,
      this.message,
      this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark,});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);


}

@JsonSerializable()
class Records {
  String emp_ID;
  String emp_Code;
  String emp_Name;
  String user_ID;
  String emp_MobileNo;
  String emp_EmailID;
  String emp_Photo;
  String branchID;
  String branchCode;
  String branchName;
  String schoolID;
  String schoolCode;
  String schoolName;
  String schoolLogo;
  String emp_TypeID;
  String currentSessionId;

  Records({
  this.emp_ID="",
  this.emp_Code="",
  this.user_ID="",
  this.emp_Name="",
  this.emp_MobileNo="",
  this.emp_EmailID="",
  this.emp_Photo="",
  this.branchID="",
  this.branchCode="",
  this.branchName="",
  this.schoolID="",
  this.schoolCode="",
  this.schoolName="",
  this.schoolLogo="",
  this.emp_TypeID="",
  this.currentSessionId="",
  });

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);


}