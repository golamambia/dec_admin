import 'package:json_annotation/json_annotation.dart';

part 'mark_info_model.g.dart';

@JsonSerializable()
class MarkInfoModel {
  bool? status;
  String? message;
  List<InfoRecords>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  MarkInfoModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory MarkInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MarkInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkInfoModelToJson(this);
}

@JsonSerializable()
class InfoRecords {
  String? examID;
  String? examName;
  String? maxMarks;
  String? subjectID;
  String? subjectName;

  InfoRecords(
      {
        this.examID,
        this.examName,
        this.maxMarks,
        this.subjectID,
        this.subjectName,
});

  factory InfoRecords.fromJson(Map<String, dynamic> json) => _$InfoRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$InfoRecordsToJson(this);
}
