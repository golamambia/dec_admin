// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentModel _$InstallmentModelFromJson(Map<String, dynamic> json) =>
    InstallmentModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>)
          .map((e) => InstallmentRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$InstallmentModelToJson(InstallmentModel instance) =>
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

InstallmentRecord _$InstallmentRecordFromJson(Map<String, dynamic> json) =>
    InstallmentRecord(
      installmentID: json['installmentID'] as String?,
      sessionID: json['sessionID'] as String?,
      slNo: json['slNo'] as String?,
      insT_Name: json['insT_Name'] as String?,
      insT_Due_Date: json['insT_Due_Date'] as String?,
      insT_Limit_Date: json['insT_Limit_Date'] as String?,
      installmentMappID: json['installmentMappID'] as String?,
      monthID: json['monthID'] as String?,
      monthName: json['monthName'] as String?,
      receiptDate: json['receiptDate'] as String?,
    );

Map<String, dynamic> _$InstallmentRecordToJson(InstallmentRecord instance) =>
    <String, dynamic>{
      'installmentID': instance.installmentID,
      'sessionID': instance.sessionID,
      'slNo': instance.slNo,
      'insT_Name': instance.insT_Name,
      'insT_Due_Date': instance.insT_Due_Date,
      'insT_Limit_Date': instance.insT_Limit_Date,
      'installmentMappID': instance.installmentMappID,
      'monthID': instance.monthID,
      'monthName': instance.monthName,
      'receiptDate': instance.receiptDate,
    };
