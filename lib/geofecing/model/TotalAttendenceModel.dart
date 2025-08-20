class TotalAttendenceModel {
  TotalAttendenceModel({
      this.status, 
      this.message, 
      this.records, 
      this.commondata, 
      this.formStatus, 
      this.subType, 
      this.grades, 
      this.subjectMark,});

  TotalAttendenceModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['records'] != null) {
      records = [];
      json['records'].forEach((v) {
        records?.add(Records.fromJson(v));
      });
    }
    commondata = json['commondata'];
    formStatus = json['formStatus'];
    subType = json['sub_type'];
    grades = json['grades'];
    subjectMark = json['subject_mark'];
  }
  bool? status;
  String? message;
  List<Records>? records;
  dynamic commondata;
  dynamic formStatus;
  dynamic subType;
  dynamic grades;
  dynamic subjectMark;
TotalAttendenceModel copyWith({  bool? status,
  String? message,
  List<Records>? records,
  dynamic commondata,
  dynamic formStatus,
  dynamic subType,
  dynamic grades,
  dynamic subjectMark,
}) => TotalAttendenceModel(  status: status ?? this.status,
  message: message ?? this.message,
  records: records ?? this.records,
  commondata: commondata ?? this.commondata,
  formStatus: formStatus ?? this.formStatus,
  subType: subType ?? this.subType,
  grades: grades ?? this.grades,
  subjectMark: subjectMark ?? this.subjectMark,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (records != null) {
      map['records'] = records?.map((v) => v.toJson()).toList();
    }
    map['commondata'] = commondata;
    map['formStatus'] = formStatus;
    map['sub_type'] = subType;
    map['grades'] = grades;
    map['subject_mark'] = subjectMark;
    return map;
  }

}

class Records {
  Records({
      this.stid, 
      this.rolLNo, 
      this.sTNAME, 
      this.fatheRNAME, 
      this.attendance, 
      this.total, 
      this.present, 
      this.absent,});

  Records.fromJson(dynamic json) {
    stid = json['stid'];
    rolLNo = json['rolL_No'];
    sTNAME = json['sT_NAME'];
    fatheRNAME = json['fatheR_NAME'];
    attendance = json['attendance'];
    total = json['total'];
    present = json['present'];
    absent = json['absent'];
  }
  dynamic stid;
  dynamic rolLNo;
  dynamic sTNAME;
  dynamic fatheRNAME;
  dynamic attendance;
  String? total;
  String? present;
  String? absent;
Records copyWith({  dynamic stid,
  dynamic rolLNo,
  dynamic sTNAME,
  dynamic fatheRNAME,
  dynamic attendance,
  String? total,
  String? present,
  String? absent,
}) => Records(  stid: stid ?? this.stid,
  rolLNo: rolLNo ?? this.rolLNo,
  sTNAME: sTNAME ?? this.sTNAME,
  fatheRNAME: fatheRNAME ?? this.fatheRNAME,
  attendance: attendance ?? this.attendance,
  total: total ?? this.total,
  present: present ?? this.present,
  absent: absent ?? this.absent,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stid'] = stid;
    map['rolL_No'] = rolLNo;
    map['sT_NAME'] = sTNAME;
    map['fatheR_NAME'] = fatheRNAME;
    map['attendance'] = attendance;
    map['total'] = total;
    map['present'] = present;
    map['absent'] = absent;
    return map;
  }

}