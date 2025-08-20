import 'package:json_annotation/json_annotation.dart';

part 'student_search_model.g.dart';

@JsonSerializable()
class StudentSearchModel {
  bool? status;
  String? message;
  List<StudentSearchRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  StudentSearchModel({
    this.status,
    this.message,
    this.records,
    this.commondata,
    this.formStatus,
    this.sub_type,
    this.grades,
    this.subject_mark,
  });

  factory StudentSearchModel.fromJson(Map<String, dynamic> json) =>
      _$StudentSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentSearchModelToJson(this);
}

@JsonSerializable()
class StudentSearchRecord {
  @JsonKey(name: "value")
  String? label;
  @JsonKey(name: "sT_ID")
  String? value;

  StudentSearchRecord({
    this.label,
    this.value,
  });

  factory StudentSearchRecord.fromJson(Map<String, dynamic> json) =>
      _$StudentSearchRecordFromJson(json);

  Map<String, dynamic> toJson() => _$StudentSearchRecordToJson(this);
}
