
import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {

  bool?  status;
  String ? message;
  List<Records>?  records;
  String ? commondata;
  String ? formStatus;
  String ? sub_type;
  String ? grades;
  String? subject_mark;

  SignupModel({
      this.status,
      this.message,
      this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark,});

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);


}

@JsonSerializable()
class Records {
  String userID;
  String branchID;

  Records({
  this.userID="",
  this.branchID="",
  });

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);


}