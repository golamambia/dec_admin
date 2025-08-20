// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => EmployeeRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'records': instance.records,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

EmployeeRecord _$EmployeeRecordFromJson(Map<String, dynamic> json) =>
    EmployeeRecord(
      emp_ID: json['emp_ID'] as String?,
      emp_Code: json['emp_Code'] as String?,
      emp_Title: json['emp_Title'] as String?,
      emp_Name: json['emp_Name'] as String?,
      user_ID: json['user_ID'] as String?,
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
    );

Map<String, dynamic> _$EmployeeRecordToJson(EmployeeRecord instance) =>
    <String, dynamic>{
      'emp_ID': instance.emp_ID,
      'emp_Code': instance.emp_Code,
      'emp_Title': instance.emp_Title,
      'emp_Name': instance.emp_Name,
      'user_ID': instance.user_ID,
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
    };
