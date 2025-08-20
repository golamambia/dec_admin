import 'package:json_annotation/json_annotation.dart';

part 'bulletin_model.g.dart';

@JsonSerializable()
class BulletinModel {
  bool? status;
  String? message;
  String? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  BulletinModel({
    this.status,
    this.message,
    this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory BulletinModel.fromJson(Map<String, dynamic> json) =>
      _$BulletinModelFromJson(json);

  Map<String, dynamic> toJson() => _$BulletinModelToJson(this);
}

// @JsonSerializable()
// class BulletinRecord {
//   String? tempid;
//   String? messageTitle;
//   String? message;
//
//   BulletinRecord({
//     this.tempid,
//     this.messageTitle,
//     this.message,
//   });
//
//   factory BulletinRecord.fromJson(Map<String, dynamic> json) =>
//       _$BulletinRecordFromJson(json);
//
//   Map<String, dynamic> toJson() => _$BulletinRecordToJson(this);
// }
