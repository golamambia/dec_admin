import 'package:json_annotation/json_annotation.dart';

part 'class_list.g.dart';

@JsonSerializable()
class ClassList {
  bool? status;
  String? message;
  List<ClassRecord> records;
  String? commondata;
  String? formStatus;
  String? sub_type;
  String? grades;
  String? subject_mark;

  ClassList(
      {this.status,
      this.message,
      required this.records,
      this.commondata,
      this.formStatus,
      this.sub_type,
      this.grades,
      this.subject_mark});

  factory ClassList.fromJson(Map<String, dynamic> json) =>
      _$ClassListFromJson(json);

  Map<String, dynamic> toJson() => _$ClassListToJson(this);
}

@JsonSerializable()
class ClassRecord {
  String? classID;
  String? className;
  String? classSection;
  String? classsStandard;
  String? recessPeriod;
  String? totalPeriodDay;
  String? workDays;
  String? actualPeriodWeek;
  String? ddlClassName;


  @override
  String toString() {
    return 'ClassRecord{classID: $classID, className: $className, classSection: $classSection, classsStandard: $classsStandard, recessPeriod: $recessPeriod, totalPeriodDay: $totalPeriodDay, workDays: $workDays, actualPeriodWeek: $actualPeriodWeek, ddlClassName: $ddlClassName}';
  }

  ClassRecord(
      {this.classID,
      this.className,
      this.classSection,
      this.classsStandard,
      this.recessPeriod,
      this.totalPeriodDay,
      this.workDays,
      this.actualPeriodWeek,
      this.ddlClassName});

  factory ClassRecord.fromJson(Map<String, dynamic> json) => _$ClassRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ClassRecordToJson(this);
}
