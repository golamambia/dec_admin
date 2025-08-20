import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  bool? status;
  String? message;
  List<MessageRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  MessageModel({
    this.status,
    this.message,
   required this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

@JsonSerializable()
class MessageRecord {
  String? tempid;
  String? messageTitle;
  String? message;

  MessageRecord({
    this.tempid,
    this.messageTitle,
    this.message,
  });

  factory MessageRecord.fromJson(Map<String, dynamic> json) =>
      _$MessageRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRecordToJson(this);
}
