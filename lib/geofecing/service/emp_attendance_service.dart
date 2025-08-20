import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';
import '../model/attendance_model.dart';

class EmpAttendanceService extends GetxController implements GetxService {
  var totalEmpAttendance = AttendanceModel().obs;
  var todayEmpAttendance = AttendanceModel().obs;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  var map = <DateTime, int>{}.obs;
  var heatMapData = <DateTime, int>{}.obs;

  Future<dynamic> getEmpAttendanceInfo() async {
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "EMPAttendaceApp",
      "EmpID": CommonService.employeeId
    };
    try {
      EasyLoading.show();
      final response = await Dio().post(
        EndPoints.AttendanceEmp,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );

      Get.log("Attendance req : ${data}");
      Get.log("Attendance : $response");

      if (response.data["status"]) {
        EasyLoading.dismiss();
        EasyLoading.dismiss();

        totalEmpAttendance.value = AttendanceModel.fromJson(response.data);

        totalEmpAttendance.value.academics?.forEach((e) {
          var date = dateFormat.parse(e.date!);
          var num = e.attendance.toInt();
          map[date] = num;
          Get.log("attendance Data: ${e.date}");
          Get.log("attendance Data: ${date}");
          Get.log("attendance type: ${num}");
        });

        print(map.toString());

        return totalEmpAttendance.value;
      } else {
        EasyLoading.dismiss();
        //Ams.ft("${response.data["message"]}");
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Get.log("${e.response}");
    }
  }

  Future<bool> getTodayEmpAttendanceInfo() async {
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "GetERPEmpTodayeAttendance",
      "EmpID": CommonService.employeeId
    };
    try {
      EasyLoading.show();
      final response = await Dio().post(
        EndPoints.todayEmpAttendance,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );

      Get.log("Attendance req : ${data}");
      Get.log("Attendance : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        todayEmpAttendance.value = AttendanceModel.fromJson(response.data);
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Get.log("${e.response}");
    }
    return false;

  }

  Future<bool> saveAutoEmpAttendance() async {
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "AutoSaveEmp",
      "EmpID": CommonService.employeeId
    };
    try {
      EasyLoading.show();
      final response = await Dio().post(
        EndPoints.UpdateAttendanceEmp,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );

      Get.log("Attendance req : ${data}");
      Get.log("Attendance : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Get.log("${e.response}");
    }
    return false;

  }

  Future<bool> saveLocation({
    required latitude,
    required longitude,
}) async {
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "Save",
      "EmpID": CommonService.employeeId,
      "Latitude":latitude,
      "longitude":longitude,
      "timestamp":"2024-10-30",
      "altitude":"0",
      "heading":"0",
      "headingAccuracy":"45",
      "speed":"0",
      "speedAccuracy":"1.5"

    };
    try {
      EasyLoading.show();
      final response = await Dio().post(
        EndPoints.UpdateLocation,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );

      Get.log("Attendance req : ${data}");
      Get.log("Attendance : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Get.log("${e.response}");
    }
    return false;
  }

}
