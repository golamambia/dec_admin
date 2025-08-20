

import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  bool? status;
  String? message;
  List<NotificationRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  NotificationModel({
    this.status,
    this.message,
    required this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationRecord {
  String? title;
  String? msgBody;
  String? createdDate;

  NotificationRecord({
    this.title,
    this.msgBody,
    this.createdDate,
  });

  factory NotificationRecord.fromJson(Map<String, dynamic> json) =>
      _$NotificationRecordFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRecordToJson(this);
}