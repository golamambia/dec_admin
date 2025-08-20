import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  bool? status;
  String? message;
  List<EmployeeRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  EmployeeModel({
    this.status,
    this.message,
    required this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}

@JsonSerializable()
class EmployeeRecord {
  String? emp_ID;
  String? emp_Code;
  String? emp_Title;
  String? emp_Name;
  String? user_ID;
  String? emp_Gender;
  String? emp_CurrentAddress;
  String? emp_PermamentAddress;
  String? emp_MobileNo;
  String? passCode;
  String? emp_AlternateNo;
  String? emp_EmailID;
  String? emp_DOB;
  String? emp_DOJ;
  String? emp_MaritialStatus;
  String? doAnniversary;
  String? religion;
  String? emp_TypeID;
  String? emp_DesignationID;
  String? emp_DepartmentID;
  String? aadharNo;
  String? paN_No;
  String? providentFundNo;
  String? bloodGroup;
  String? nationality;
  String? maxPeriod;
  String? wingID;
  String? religionID;
  String? categoryID;
  String? casteID;
  String? jobType;
  String? subjectExpertise;
  String? guardianName;
  String? guardianReletion;
  String? identityType;
  String? identityFIlePath;
  String? signature;
  String? emp_Photo;
  String? bankName;
  String? ifsc;
  String? accountNo;
  String? leaveClassID;

  EmployeeRecord({
    this.emp_ID,
    this.emp_Code,
    this.emp_Title,
    this.emp_Name,
    this.user_ID,
    this.emp_Gender,
    this.emp_CurrentAddress,
    this.emp_PermamentAddress,
    this.emp_MobileNo,
    this.passCode,
    this.emp_AlternateNo,
    this.emp_EmailID,
    this.emp_DOB,
    this.emp_DOJ,
    this.emp_MaritialStatus,
    this.doAnniversary,
    this.religion,
    this.emp_TypeID,
    this.emp_DesignationID,
    this.emp_DepartmentID,
    this.aadharNo,
    this.paN_No,
    this.providentFundNo,
    this.bloodGroup,
    this.nationality,
    this.maxPeriod,
    this.wingID,
    this.religionID,
    this.categoryID,
    this.casteID,
    this.jobType,
    this.subjectExpertise,
    this.guardianName,
    this.guardianReletion,
    this.identityType,
    this.identityFIlePath,
    this.signature,
    this.emp_Photo,
    this.bankName,
    this.ifsc,
    this.accountNo,
    this.leaveClassID,
  });

  factory EmployeeRecord.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRecordFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeRecordToJson(this);
}
