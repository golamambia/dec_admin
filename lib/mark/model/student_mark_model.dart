import 'package:json_annotation/json_annotation.dart';

part 'student_mark_model.g.dart';

@JsonSerializable()
class StudentMarkModel {
  bool? status;
  String? message;
  List<StudentMarkRecords>? school;
  List<GradeRecords>? academics;
  List<SettingRecords>? setting;
  List<Footer>? footer;
  String? profile;
  String? schoolProfile;
  String? branchList;
  String? count;

  StudentMarkModel(
      {this.status,
      this.message,
      this.setting,
      this.school,
      this.academics,
      this.footer,
      this.profile,
      this.schoolProfile,
      this.branchList,
      this.count});

  factory StudentMarkModel.fromJson(Map<String, dynamic> json) =>
      _$StudentMarkModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentMarkModelToJson(this);
}

@JsonSerializable()
class Footer {
  String? isPersmission;

  Footer({
    this.isPersmission,

  });

  factory Footer.fromJson(Map<String, dynamic> json) =>
      _$FooterFromJson(json);

  Map<String, dynamic> toJson() => _$FooterToJson(this);
}

@JsonSerializable()
class StudentMarkRecords {
  String? sT_ID;
  String? rollNo;
  String? sT_Name;
  String? guardianName;
  String? marks;
  String? grade;


  // @override
  // String toString() {
  //   return 'StudentMarkRecords{sT_ID: $sT_ID, rollNo: $rollNo, sT_Name: $sT_Name, guardianName: $guardianName, marks: $marks, grade: $grade}';
  // }

  StudentMarkRecords({
    this.sT_ID,
    this.rollNo,
    this.sT_Name,
    this.guardianName,
    this.marks,
    this.grade,
  });

  factory StudentMarkRecords.fromJson(Map<String, dynamic> json) =>
      _$StudentMarkRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$StudentMarkRecordsToJson(this);
}

@JsonSerializable()
class GradeRecords {
  String? grade;

  GradeRecords({
    this.grade,
  });

  factory GradeRecords.fromJson(Map<String, dynamic> json) =>
      _$GradeRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$GradeRecordsToJson(this);
}

@JsonSerializable()
class SettingRecords {
  String? grade;

  SettingRecords({
    this.grade,
  });

  factory SettingRecords.fromJson(Map<String, dynamic> json) =>
      _$SettingRecordsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingRecordsToJson(this);
}
