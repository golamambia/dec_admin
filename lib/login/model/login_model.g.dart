// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: json['records'] == null
          ? null
          : Records.fromJson(json['records'] as Map<String, dynamic>),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
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

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      emp_ID: json['emp_ID'] as String? ?? "",
      emp_Code: json['emp_Code'] as String? ?? "",
      user_ID: json['user_ID'] as String? ?? "",
      emp_Name: json['emp_Name'] as String? ?? "",
      emp_MobileNo: json['emp_MobileNo'] as String? ?? "",
      emp_EmailID: json['emp_EmailID'] as String? ?? "",
      emp_Photo: json['emp_Photo'] as String? ?? "",
      branchID: json['branchID'] as String? ?? "",
      branchCode: json['branchCode'] as String? ?? "",
      branchName: json['branchName'] as String? ?? "",
      schoolID: json['schoolID'] as String? ?? "",
      schoolCode: json['schoolCode'] as String? ?? "",
      schoolName: json['schoolName'] as String? ?? "",
      schoolLogo: json['schoolLogo'] as String? ?? "",
      emp_TypeID: json['emp_TypeID'] as String? ?? "",
      currentSessionId: json['currentSessionId'] as String? ?? "",
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'emp_ID': instance.emp_ID,
      'emp_Code': instance.emp_Code,
      'emp_Name': instance.emp_Name,
      'user_ID': instance.user_ID,
      'emp_MobileNo': instance.emp_MobileNo,
      'emp_EmailID': instance.emp_EmailID,
      'emp_Photo': instance.emp_Photo,
      'branchID': instance.branchID,
      'branchCode': instance.branchCode,
      'branchName': instance.branchName,
      'schoolID': instance.schoolID,
      'schoolCode': instance.schoolCode,
      'schoolName': instance.schoolName,
      'schoolLogo': instance.schoolLogo,
      'emp_TypeID': instance.emp_TypeID,
      'currentSessionId': instance.currentSessionId,
    };
