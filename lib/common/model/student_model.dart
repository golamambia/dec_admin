import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable()
class StudentModel {
  bool? status;
  String? message;
  List<StudentRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  StudentModel({
    this.status,
    this.message,
    required this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}

@JsonSerializable()
class StudentRecord {
  String? name;
  String? sT_ID;
  String? user_ID;
  String? sT_PermanentEduNo;
  String? branchID;
  String? admnNo;
  String? classID;
  String? className;
  String? rollNo;
  String? sT_Name;
  String? sT_DOB;
  String? sT_DOA;
  String? sT_Address;
  String? guardianName;
  String? guardianMobile;
  String? guardianEmail;
  String? guardianReletion;
  String? guardianAadharNo;
  String? passCode;
  String? blood_Group;
  String? sT_Gender;
  String? hobby;
  String? sT_Nationality;
  String? religion;
  String? casteID;
  String? categoryID;
  String? billBookNo;
  String? admittedInClass;
  String? sT_AadharNo;
  String? staffWard;
  String? staffCode;
  String? is_Boarding;
  String? is_New_Admn;
  String? is_Transport;
  String? is_ICard;
  String? previousSchool;
  String? previousSchoolAddress;
  String? lastClassAttendedInPreviousSchool;
  String? previousSchoolLeftYear;
  String? houseID;
  String? photo;
  String? sR_No;
  String? boardRegNo;
  String? father_Name;
  String? father_DOB;
  String? father_Qualification;
  String? father_Profession;
  String? father_Designation;
  String? father_ResiAdd;
  String? father_OffAdd;
  String? father_Mobile;
  String? father_Off_Mobile;
  String? father_Email;
  String? father_AadharNo;
  String? father_PanNo;
  String? father_Income_Yearly;
  String? father_Photo;
  String? mother_Name;
  String? mother_DOB;
  String? mother_Qualification;
  String? mother_Profession;
  String? mother_Designation;
  String? mother_ResiAdd;
  String? mother_OffAdd;
  String? mother_Mobile;
  String? mother_Off_Mobile;
  String? mother_Email;
  String? mother_AadharNo;
  String? mother_PanNo;
  String? mother_Income_Yearly;
  String? mother_Photo;
  String? dateOfanniversary;
  String? enquiryNo;
  String? groupName;
  String? chkStdId;
  String? isCheckedOrNot;
  String? attrVal;
  String? schoolBoard;
  String? stdStrength;
  StudentRecord({
    this.name,
    this.sT_ID,
    this.user_ID,
    this.sT_PermanentEduNo,
    this.branchID,
    this.admnNo,
    this.classID,
    this.className,
    this.rollNo,
    this.sT_Name,
    this.sT_DOB,
    this.sT_DOA,
    this.sT_Address,
    this.guardianName,
    this.guardianMobile,
    this.guardianEmail,
    this.guardianReletion,
    this.guardianAadharNo,
    this.passCode,
    this.blood_Group,
    this.sT_Gender,
    this.hobby,
    this.sT_Nationality,
    this.religion,
    this.casteID,
    this.categoryID,
    this.billBookNo,
    this.admittedInClass,
    this.sT_AadharNo,
    this.staffWard,
    this.staffCode,
    this.is_Boarding,
    this.is_New_Admn,
    this.is_Transport,
    this.is_ICard,
    this.previousSchool,
    this.previousSchoolAddress,
    this.lastClassAttendedInPreviousSchool,
    this.previousSchoolLeftYear,
    this.houseID,
    this.photo,
    this.sR_No,
    this.boardRegNo,
    this.father_Name,
    this.father_DOB,
    this.father_Qualification,
    this.father_Profession,
    this.father_Designation,
    this.father_ResiAdd,
    this.father_OffAdd,
    this.father_Mobile,
    this.father_Off_Mobile,
    this.father_Email,
    this.father_AadharNo,
    this.father_PanNo,
    this.father_Income_Yearly,
    this.father_Photo,
    this.mother_Name,
    this.mother_DOB,
    this.mother_Qualification,
    this.mother_Profession,
    this.mother_Designation,
    this.mother_ResiAdd,
    this.mother_OffAdd,
    this.mother_Mobile,
    this.mother_Off_Mobile,
    this.mother_Email,
    this.mother_AadharNo,
    this.mother_PanNo,
    this.mother_Income_Yearly,
    this.mother_Photo,
    this.dateOfanniversary,
    this.enquiryNo,
    this.groupName,
    this.chkStdId,
    this.isCheckedOrNot,
    this.attrVal,
    this.schoolBoard,
    this.stdStrength,
  });

  factory StudentRecord.fromJson(Map<String, dynamic> json) =>
      _$StudentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$StudentRecordToJson(this);
}
