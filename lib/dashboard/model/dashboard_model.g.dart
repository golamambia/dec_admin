// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      school: (json['school'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      academics: (json['academics'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      setting: (json['setting'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      footer: (json['footer'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..profile = (json['profile'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList()
      ..schoolProfile = (json['schoolProfile'] as List<dynamic>?)
          ?.map((e) => SchoolProfile.fromJson(e as Map<String, dynamic>))
          .toList()
      ..branchList = (json['branchList'] as List<dynamic>?)
          ?.map((e) => BranchList.fromJson(e as Map<String, dynamic>))
          .toList()
      ..locationSettings = (json['locationSettings'] as List<dynamic>?)
          ?.map((e) => LocationSettings.fromJson(e as Map<String, dynamic>))
          .toList()
      ..count = (json['count'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'school': instance.school,
      'academics': instance.academics,
      'setting': instance.setting,
      'footer': instance.footer,
      'profile': instance.profile,
      'schoolProfile': instance.schoolProfile,
      'branchList': instance.branchList,
      'locationSettings': instance.locationSettings,
      'count': instance.count,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      school_code: json['school_code'] as String?,
      menuID: json['menuID'] as String?,
      type: json['type'] as String?,
      nav: json['nav'] as String?,
      headerName: json['headerName'] as String?,
      menuName: json['menuName'] as String?,
      imgURL: json['imgURL'] as String?,
      colorCode: json['colorCode'] as String?,
      isActive: json['isActive'] as String?,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'school_code': instance.school_code,
      'menuID': instance.menuID,
      'type': instance.type,
      'nav': instance.nav,
      'headerName': instance.headerName,
      'menuName': instance.menuName,
      'imgURL': instance.imgURL,
      'colorCode': instance.colorCode,
      'isActive': instance.isActive,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      emp_ID: json['emp_ID'] as String?,
      emp_Code: json['emp_Code'] as String?,
      emp_Title: json['emp_Title'] as String?,
      emp_Name: json['emp_Name'] as String?,
      emp_Gender: json['emp_Gender'] as String?,
      emp_CurrentAddress: json['emp_CurrentAddress'] as String?,
      emp_PermamentAddress: json['emp_PermamentAddress'] as String?,
      emp_MobileNo: json['emp_MobileNo'] as String?,
      passCode: json['passCode'] as String?,
      emp_AlternateNo: json['emp_AlternateNo'] as String?,
      emp_EmailID: json['emp_EmailID'] as String?,
      emp_DOB: json['emp_DOB'] as String?,
      emp_DOJ: json['emp_DOJ'] as String?,
      emp_MaritialStatus: json['emp_MaritialStatus'] as String?,
      doAnniversary: json['doAnniversary'] as String?,
      religion: json['religion'] as String?,
      emp_TypeID: json['emp_TypeID'] as String?,
      emp_DesignationID: json['emp_DesignationID'] as String?,
      emp_DepartmentID: json['emp_DepartmentID'] as String?,
      aadharNo: json['aadharNo'] as String?,
      paN_No: json['paN_No'] as String?,
      providentFundNo: json['providentFundNo'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      nationality: json['nationality'] as String?,
      maxPeriod: json['maxPeriod'] as String?,
      wingID: json['wingID'] as String?,
      religionID: json['religionID'] as String?,
      categoryID: json['categoryID'] as String?,
      casteID: json['casteID'] as String?,
      jobType: json['jobType'] as String?,
      subjectExpertise: json['subjectExpertise'] as String?,
      guardianName: json['guardianName'] as String?,
      guardianReletion: json['guardianReletion'] as String?,
      identityType: json['identityType'] as String?,
      identityFIlePath: json['identityFIlePath'] as String?,
      signature: json['signature'] as String?,
      emp_Photo: json['emp_Photo'] as String?,
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      accountNo: json['accountNo'] as String?,
      leaveClassID: json['leaveClassID'] as String?,
      noimage: json['noimage'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'emp_ID': instance.emp_ID,
      'emp_Code': instance.emp_Code,
      'emp_Title': instance.emp_Title,
      'emp_Name': instance.emp_Name,
      'emp_Gender': instance.emp_Gender,
      'emp_CurrentAddress': instance.emp_CurrentAddress,
      'emp_PermamentAddress': instance.emp_PermamentAddress,
      'emp_MobileNo': instance.emp_MobileNo,
      'passCode': instance.passCode,
      'emp_AlternateNo': instance.emp_AlternateNo,
      'emp_EmailID': instance.emp_EmailID,
      'emp_DOB': instance.emp_DOB,
      'emp_DOJ': instance.emp_DOJ,
      'emp_MaritialStatus': instance.emp_MaritialStatus,
      'doAnniversary': instance.doAnniversary,
      'religion': instance.religion,
      'emp_TypeID': instance.emp_TypeID,
      'emp_DesignationID': instance.emp_DesignationID,
      'emp_DepartmentID': instance.emp_DepartmentID,
      'aadharNo': instance.aadharNo,
      'paN_No': instance.paN_No,
      'providentFundNo': instance.providentFundNo,
      'bloodGroup': instance.bloodGroup,
      'nationality': instance.nationality,
      'maxPeriod': instance.maxPeriod,
      'wingID': instance.wingID,
      'religionID': instance.religionID,
      'categoryID': instance.categoryID,
      'casteID': instance.casteID,
      'jobType': instance.jobType,
      'subjectExpertise': instance.subjectExpertise,
      'guardianName': instance.guardianName,
      'guardianReletion': instance.guardianReletion,
      'identityType': instance.identityType,
      'identityFIlePath': instance.identityFIlePath,
      'signature': instance.signature,
      'emp_Photo': instance.emp_Photo,
      'bankName': instance.bankName,
      'ifsc': instance.ifsc,
      'accountNo': instance.accountNo,
      'leaveClassID': instance.leaveClassID,
      'noimage': instance.noimage,
    };

SchoolProfile _$SchoolProfileFromJson(Map<String, dynamic> json) =>
    SchoolProfile(
      schoolCode: json['schoolCode'] as String?,
      schoolName: json['schoolName'] as String?,
      branchID: json['branchID'] as String?,
      branchCode: json['branchCode'] as String?,
      branchName: json['branchName'] as String?,
      branchBoard: json['branchBoard'] as String?,
      branchAddress: json['branchAddress'] as String?,
      contactNo: json['contactNo'] as String?,
      emailID: json['emailID'] as String?,
      empExists: json['empExists'] as String?,
      affiliationNo: json['affiliationNo'] as String?,
      codeByBoard: json['codeByBoard'] as String?,
      landlineNo: json['landlineNo'] as String?,
      alternateMobile1: json['alternateMobile1'] as String?,
      alternateMobile2: json['alternateMobile2'] as String?,
      shortName: json['shortName'] as String?,
      website: json['website'] as String?,
      supportEmail: json['supportEmail'] as String?,
      pan: json['pan'] as String?,
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      acNo: json['acNo'] as String?,
      upiNo: json['upiNo'] as String?,
      schoolLogo: json['schoolLogo'] as String?,
      mobileAppBG: json['mobileAppBG'] as String?,
    );

Map<String, dynamic> _$SchoolProfileToJson(SchoolProfile instance) =>
    <String, dynamic>{
      'schoolCode': instance.schoolCode,
      'schoolName': instance.schoolName,
      'branchID': instance.branchID,
      'branchCode': instance.branchCode,
      'branchName': instance.branchName,
      'branchBoard': instance.branchBoard,
      'branchAddress': instance.branchAddress,
      'contactNo': instance.contactNo,
      'emailID': instance.emailID,
      'empExists': instance.empExists,
      'affiliationNo': instance.affiliationNo,
      'codeByBoard': instance.codeByBoard,
      'landlineNo': instance.landlineNo,
      'alternateMobile1': instance.alternateMobile1,
      'alternateMobile2': instance.alternateMobile2,
      'shortName': instance.shortName,
      'website': instance.website,
      'supportEmail': instance.supportEmail,
      'pan': instance.pan,
      'bankName': instance.bankName,
      'ifsc': instance.ifsc,
      'acNo': instance.acNo,
      'upiNo': instance.upiNo,
      'schoolLogo': instance.schoolLogo,
      'mobileAppBG': instance.mobileAppBG,
    };

BranchList _$BranchListFromJson(Map<String, dynamic> json) => BranchList(
      branchID: json['branchID'] as String?,
      branchCode: json['branchCode'] as String?,
      branchName: json['branchName'] as String?,
    );

Map<String, dynamic> _$BranchListToJson(BranchList instance) =>
    <String, dynamic>{
      'branchID': instance.branchID,
      'branchCode': instance.branchCode,
      'branchName': instance.branchName,
    };

LocationSettings _$LocationSettingsFromJson(Map<String, dynamic> json) =>
    LocationSettings(
      json['school_code'] as String?,
      json['type'] as String?,
      json['latitude'] as String?,
      json['longitude'] as String?,
      json['timestamp'] as String?,
      json['altitude'] as String?,
      json['heading'] as String?,
      json['headingAccuracy'] as String?,
      json['speed'] as String?,
      json['speedAccuracy'] as String?,
      json['branchID'] as String?,
      json['empID'] as String?,
    );

Map<String, dynamic> _$LocationSettingsToJson(LocationSettings instance) =>
    <String, dynamic>{
      'school_code': instance.school_code,
      'type': instance.type,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timestamp': instance.timestamp,
      'altitude': instance.altitude,
      'heading': instance.heading,
      'headingAccuracy': instance.headingAccuracy,
      'speed': instance.speed,
      'speedAccuracy': instance.speedAccuracy,
      'branchID': instance.branchID,
      'empID': instance.empID,
    };

Count _$CountFromJson(Map<String, dynamic> json) => Count(
      todayCollection: json['todayCollection'] as String?,
      todayDue: json['todayDue'] as String?,
      studentStrength: json['studentStrength'] as String?,
      boys: json['boys'] as String?,
      girls: json['girls'] as String?,
      studentPresent: json['studentPresent'] as String?,
      studentAbsent: json['studentAbsent'] as String?,
      teacherPresent: json['teacherPresent'] as String?,
      teachertAbsent: json['teachertAbsent'] as String?,
    );

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
      'todayCollection': instance.todayCollection,
      'todayDue': instance.todayDue,
      'studentStrength': instance.studentStrength,
      'boys': instance.boys,
      'girls': instance.girls,
      'studentPresent': instance.studentPresent,
      'studentAbsent': instance.studentAbsent,
      'teacherPresent': instance.teacherPresent,
      'teachertAbsent': instance.teachertAbsent,
    };
