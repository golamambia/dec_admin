import 'package:json_annotation/json_annotation.dart';

part 'syllabus_model.g.dart';

@JsonSerializable()
class SyllabusModel {
  bool? status;
  String? message;
  List<SyllabusRecord>? records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  SyllabusModel(
      {this.status,
        this.message,
        this.records,
        this.commondata,
        this.formStatus,
        this.sub_type,
        this.grades,
        this.subject_mark});

  factory SyllabusModel.fromJson(Map<String, dynamic> json) =>
      _$SyllabusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusModelToJson(this);
}

@JsonSerializable()
class SyllabusRecord  {
  String? syllabusID;
  String? title;
  String? filePath;
  String? classID;
  String? className;
  String? uploadDate;
  String? empID;
  String? branchID;
  String? school_code;
  String? type;


  @override
  String toString() {
    return 'SyllabusRecord{syllabusID: $syllabusID, title: $title, filePath: $filePath, classID: $classID, className: $className, uploadDate: $uploadDate, empID: $empID, branchID: $branchID, school_code: $school_code, type: $type}';
  }

  SyllabusRecord(
      {
        this.syllabusID,
        this.title,
        this.filePath,
        this.classID,
        this.className,
        this.uploadDate,
        this.empID,
        this.branchID,
        this.school_code,
        this.type,
      });

  factory SyllabusRecord.fromJson(Map<String, dynamic> json) =>
  _$SyllabusRecordFromJson(json);

  Map<String, dynamic> toJson() => _$SyllabusRecordToJson(this);

}
