import 'package:decora_admin/attendance/service/attendance_service.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/attendance_model.dart';
import '../model/periods_model.dart';

class AttendanceController extends GetxController {
  var clsId = "".obs;
  var currentDate = TextEditingController();
  var currentDatePeriod = TextEditingController();

  var attendanceService = Get.put(AttendanceService());

  var attendanceModel = AttendanceModel().obs;
  var empAttendanceModel = AttendanceModel().obs;
  var empPeriodsModel = PeriodsModel().obs;

  var isSMS = 0;

  var radioOption = 1.obs;

  void clsCallback(String? callBackClsId) async {
    if (clsId.value == "" || currentDate.text == "") return;
    attendanceModel.value = await attendanceService.studentAttendanceList(
        clsId: clsId.value ?? "", currentDate: currentDate.text);
  }

  void dateCallBack(String? date) async {
    if (clsId.value == "" || currentDate.text == "") return;
    attendanceModel.value = await attendanceService.studentAttendanceList(
        clsId: clsId.value, currentDate: currentDate.text);
  }

  void empDateCallBack(String? date) async {
    if (currentDate.text == "") return;
    empAttendanceModel.value = await attendanceService.empAttendanceList(
        currentDate: currentDate.text);
  }

  void empDatePeriodCallBack(String? date) async {
    if (currentDate.text == "") return;
    empPeriodsModel.value =
        await attendanceService.empPeriodsList(currentDate: currentDate.text);
  }

  void changeRadioType() {
    Get.log("onChange click: ${radioOption.value}");
    attendanceModel.value.records?.forEach(
      (element) {
        element.attenadanceMode?.value = radioOption.value;
        // Get.log("${element.attenadanceMode.value}");
      },
    );
  }

  void changeEmpRadioType() {
    Get.log("onChange click: ${radioOption.value}");
    empAttendanceModel.value.records?.forEach(
      (element) {
        element.attenadanceMode?.value = radioOption.value;
        // Get.log("${element.attenadanceMode.value}");
      },
    );
  }

  void onSave() async {
    var stuAttendanceList = attendanceModel.value.records
        ?.map((e) => {
              "ST_ID": e.sT_ID.toString(),
              "AttenadanceMode": e.attenadanceMode?.value.toString()
            })
        .toList();
    stuAttendanceList?.forEach(
      (element) {
        element.toString();
      },
    );
    var status = await attendanceService.saveStudentAttendance(
        attendanceList: stuAttendanceList,
        clsId: clsId.value,
        isSms: isSMS.toString(),
        currentDate: currentDate.text);
    if (status == true) {
      Get.back();
      Ams.ft("Saved successfully");
    } else {
      Ams.ft("Not Saved successfully!!!");
    }
  }

  void onSaveEmp() async {
    var empAttendanceList = empAttendanceModel.value.records
        ?.map((e) => {
              "Emp_ID": e.emP_ID.toString(),
              "AttenadanceMode": e.attenadanceMode?.value.toString()
            })
        .toList();
    empAttendanceList?.forEach(
      (element) {
        Get.log("Attendance: ${element.toString()}");
      },
    );
    var status = await attendanceService.saveEmpAttendance(
        empAttendanceList: empAttendanceList, currentDate: currentDate.text);
    if (status == true) {
      Get.back();
      Ams.ft("Saved successfully");
    } else {
      Ams.ft("Not Saved successfully!!!");
    }
  }

  void onDeleteStudent() async {
    var status = await attendanceService.deleteStudentAttendance(
        clsId: clsId.value, currentDate: currentDate.text);
    if (status == true) {
      Get.back();
      Ams.ft("Deleted successfully");
    } else {
      Ams.ft("Not Deleted successfully!!!");
    }
  }

  void onDeleteEmp() async {
    var status = await attendanceService.deleteEmpAttendance(
        currentDate: currentDate.text);
    if (status == true) {
      Get.back();
      Ams.ft("Deleted successfully");
    } else {
      Ams.ft("Not Deleted successfully!!!");
    }
  }

  updatePeriod(String? period, bool status) async {
    await attendanceService.saveEmpPeriod(
        currentDate: currentDatePeriod.text,
        period: period ?? "",
        status: status == true ? "1" : "0");
  }
}

// enum Option { Present, Absent, Leave, NA }
