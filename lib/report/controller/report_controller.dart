import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/common/controller/cls_controller.dart';
import 'package:decora_admin/common/employee_controller.dart';
import 'package:decora_admin/report/service/report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:decora_admin/util/Ams.dart';

class ReportController extends GetxController {
var employeeController = EmployeeController();
var clsController = ClsController();
var attendanceClr = Get.find<AttendanceController>();
  var clsId = "".obs;

  var currentDate = TextEditingController();

 var fromDate = TextEditingController();
  var toDate = TextEditingController();
   var type = TextEditingController();
  var selectedClassId = "".obs;

   void setClassId(String? clsId) {
    if (clsId == null || clsId.isEmpty) return;
    selectedClassId.value = clsId;
    print("📘 ReportController got Class ID: $clsId");

    attendanceClr.clsCallback(clsId);
  }


 void onClickDownload(String? typeval) async {
  if (type == 'class_report' && clsController.classIds.isEmpty) {
  Ams.ft("Please select class");
  return;
} else if (type == 'teacher_report' && employeeController.empIds.isEmpty) {
  Ams.ft("Please select employee");
  return;
} else if (type == 'student_report' && selectedClassId.isEmpty) {
  Ams.ft("Please select class");
  return;
}

if (fromDate.text.isEmpty) {
  Ams.ft("Please select From Date");
  return;
}

if (toDate.text.isEmpty) {
  Ams.ft("Please select To Date");
  return;
}

final result = await ReportService().postDownloadReport(
  fromDate: fromDate.text,
  toDate: toDate.text,
  type:typeval,
);

if (result) {
   
} else {
   
}
  print("📅 From Date: ${fromDate.text}");
  print("📅 To Date: ${toDate.text}");
   //print("📘 Class ID: ${selectedClassId.value}");
  // print("📘 clsController Class ID: ${clsController.classIds.value}");
   //print("📘 employeeController Class ID: ${employeeController.empIds.value}");
  
 
}

}