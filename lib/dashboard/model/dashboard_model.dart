import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel {
  bool? status;
  String? message;
  List<MenuItem>? school;
  List<MenuItem>? academics;
  List<MenuItem>? setting;
  List<MenuItem> footer;
  List<Profile>? profile;
  List<SchoolProfile>? schoolProfile;
  List<BranchList>? branchList;
  List<LocationSettings>? locationSettings;
  List<Count>? count;

  DashboardModel(
      {this.status,
      this.message,
      this.school,
      this.academics,
      this.setting,
      required this.footer});

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
}

@JsonSerializable()
class MenuItem {
  String? school_code;

  String? menuID;

  String? type;

  String? nav;

  String? headerName;

  String? menuName;

  String? imgURL;

  String? colorCode;

  String? isActive;

  MenuItem(
      {this.school_code,
      this.menuID,
      this.type,
      this.nav,
      this.headerName,
      this.menuName,
      this.imgURL,
      this.colorCode,
      this.isActive});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class Profile {
  String? emp_ID;
  String? emp_Code;
  String? emp_Title;
  String? emp_Name;
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
  String? noimage;

  Profile(
      {this.emp_ID,
      this.emp_Code,
      this.emp_Title,
      this.emp_Name,
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
      this.noimage});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class SchoolProfile {
  String? schoolCode;
  String? schoolName;
  String? branchID;
  String? branchCode;
  String? branchName;
  String? branchBoard;
  String? branchAddress;
  String? contactNo;
  String? emailID;
  String? empExists;
  String? affiliationNo;
  String? codeByBoard;
  String? landlineNo;
  String? alternateMobile1;
  String? alternateMobile2;
  String? shortName;
  String? website;
  String? supportEmail;
  String? pan;
  String? bankName;
  String? ifsc;
  String? acNo;
  String? upiNo;
  String? schoolLogo;
  String? mobileAppBG;

  SchoolProfile(
      {this.schoolCode,
      this.schoolName,
      this.branchID,
      this.branchCode,
      this.branchName,
      this.branchBoard,
      this.branchAddress,
      this.contactNo,
      this.emailID,
      this.empExists,
      this.affiliationNo,
      this.codeByBoard,
      this.landlineNo,
      this.alternateMobile1,
      this.alternateMobile2,
      this.shortName,
      this.website,
      this.supportEmail,
      this.pan,
      this.bankName,
      this.ifsc,
      this.acNo,
      this.upiNo,
      this.schoolLogo,
      this.mobileAppBG});
  factory SchoolProfile.fromJson(Map<String, dynamic> json) => _$SchoolProfileFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolProfileToJson(this);
}

@JsonSerializable()
class BranchList {
  String? branchID;
  String? branchCode;
  String? branchName;

  BranchList({this.branchID, this.branchCode, this.branchName});
  factory BranchList.fromJson(Map<String, dynamic> json) => _$BranchListFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListToJson(this);
}

@JsonSerializable()
class LocationSettings {
  String? school_code;
  String? type;
  String? latitude;
  String? longitude;
  String? timestamp;
  String? altitude;
  String? heading;
  String? headingAccuracy;
  String? speed;
  String? speedAccuracy;
  String? branchID;
  String? empID;

  LocationSettings(
      this.school_code,
      this.type,
      this.latitude,
      this.longitude,
      this.timestamp,
      this.altitude,
      this.heading,
      this.headingAccuracy,
      this.speed,
      this.speedAccuracy,
      this.branchID,
      this.empID);

  factory LocationSettings.fromJson(Map<String, dynamic> json) => _$LocationSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSettingsToJson(this);
}

@JsonSerializable()
class Count {
  String? todayCollection;
  String? todayDue;
  String? studentStrength;
  String? boys;
  String? girls;
  String? studentPresent;
  String? studentAbsent;
  String? teacherPresent;
  String? teachertAbsent;

  Count(
      {this.todayCollection,
      this.todayDue,
      this.studentStrength,
      this.boys,
      this.girls,
      this.studentPresent,
      this.studentAbsent,
      this.teacherPresent,
      this.teachertAbsent});

  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);

  Map<String, dynamic> toJson() => _$CountToJson(this);
}
