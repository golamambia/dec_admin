// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeModel _$FeeModelFromJson(Map<String, dynamic> json) => FeeModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => FeeRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      commondata: json['commondata'] as String?,
      formStatus: json['formStatus'] as String?,
      sub_type: json['sub_type'] as String?,
      grades: json['grades'] as String?,
      subject_mark: json['subject_mark'] as String?,
    );

Map<String, dynamic> _$FeeModelToJson(FeeModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'records': instance.records,
      'commondata': instance.commondata,
      'formStatus': instance.formStatus,
      'sub_type': instance.sub_type,
      'grades': instance.grades,
      'subject_mark': instance.subject_mark,
    };

FeeRecord _$FeeRecordFromJson(Map<String, dynamic> json) => FeeRecord(
      sT_ID: json['sT_ID'] as String?,
      admnNo: json['admnNo'] as String?,
      rollNo: json['rollNo'] as String?,
      sT_Name: json['sT_Name'] as String?,
      guardianName: json['guardianName'] as String?,
      sT_Address: json['sT_Address'] as String?,
      guardianMobile: json['guardianMobile'] as String?,
      className: json['class'] as String?,
      fee: json['fee'] as String?,
      trans: json['trans'] as String?,
      od: json['od'] as String?,
      fine: json['fine'] as String?,
      amt: json['amt'] as String?,
    );

Map<String, dynamic> _$FeeRecordToJson(FeeRecord instance) => <String, dynamic>{
      'sT_ID': instance.sT_ID,
      'admnNo': instance.admnNo,
      'rollNo': instance.rollNo,
      'sT_Name': instance.sT_Name,
      'guardianName': instance.guardianName,
      'sT_Address': instance.sT_Address,
      'guardianMobile': instance.guardianMobile,
      'class': instance.className,
      'fee': instance.fee,
      'trans': instance.trans,
      'od': instance.od,
      'fine': instance.fine,
      'amt': instance.amt,
    };
