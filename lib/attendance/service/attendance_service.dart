import 'dart:io';

import 'package:decora_admin/attendance/model/attendance_model.dart';
import 'package:decora_admin/attendance/model/attendance_model.dart';
import 'package:decora_admin/attendance/model/attendance_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';
import '../model/periods_model.dart';

class AttendanceService extends GetxService {
  var attendanceModel = AttendanceModel().obs;
  var empAttendanceModel = AttendanceModel().obs;
  var empPeriodsModel = PeriodsModel().obs;

  Future<AttendanceModel> studentAttendanceList({
    required String clsId,
    required String currentDate,
  }) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": AttendanceType.GetERPStdAttendancebyDate.name,
      "ClassID": clsId,
      "CurDate": currentDate
    };
    try {
      final response = await Dio().post(
        EndPoints.AttendanceList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance req  : ${data.toString()}");
      Get.log("attendance res  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return attendanceModel.value = AttendanceModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> saveStudentAttendance({
    required String clsId,
    required String isSms,
    required String currentDate,
    required List<Map<String, Object?>>? attendanceList,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": AttendanceType.SaveERPStudentAttendance.name,
      "ClassID": clsId,
      "IsSMS":isSms,
      "CurDate": currentDate,
      "objStudetnAttendance":attendanceList,
    };

    Get.log("attendance save req  : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.AttendanceUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance save req  : ${data.toString()}");
      Get.log("attendance save res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> deleteStudentAttendance({
    required String clsId,
    required String currentDate,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode.toString(),
      "BranchID": CommonService.branchId.toString(),
      "type": AttendanceType.DelERPStudentAttendance.name,
      "ClassID": clsId.toString(),
      "CurDate": currentDate.toString(),
    };
    try {
      final response = await Dio().post(
        EndPoints.AttendanceUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance req  : ${data.toString()}");
      Get.log("attendance res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<AttendanceModel> empAttendanceList({
    required String currentDate,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID":CommonService.employeeId,
      "type": "GetERPEMPAttendancebyDate",
      "AttendanceDate": currentDate
    };
    try {
      final response = await Dio().post(
        EndPoints.EmpAttendanceList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance req  : ${data.toString()}");
      Get.log("attendance res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return empAttendanceModel.value = AttendanceModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> saveEmpAttendance({
    required String currentDate,
    required List<Map<String, Object?>>? empAttendanceList,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "SaveERPEmpAttendanceApp",
      "EmpID": CommonService.employeeId,
      "AttendanceDate":currentDate,
      "objTeacher":empAttendanceList,
    };

    Get.log("attendance save req  : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.EmpAttendanceUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance save req  : ${data.toString()}");
      Get.log("attendance save res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      EasyLoading.dismiss();
      return false;
    }
  }


  Future<bool> deleteEmpAttendance({
    required String currentDate,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode.toString(),
      "BranchID": CommonService.branchId.toString(),
      "EmpID": CommonService.employeeId.toString(),
      "type": "DelERPEmpAttendanceApp",
      "AttendanceDate": currentDate.toString(),
    };
    try {
      final response = await Dio().post(
        EndPoints.EmpAttendanceUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance req  : ${data.toString()}");
      Get.log("attendance res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }


  Future<PeriodsModel> empPeriodsList({
    required String currentDate,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID":CommonService.employeeId,
      "type": "GetERPEMPAttendancebyDateForPeriod",
      "AttendanceDate": "17-11-2024"
    };
    try {
      final response = await Dio().post(
        EndPoints.EmpAttendanceList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance req  : ${data.toString()}");
      Get.log("attendance res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return empPeriodsModel.value = PeriodsModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
    return PeriodsModel();
  }


  Future<bool> saveEmpPeriod({
    required String currentDate,
    required String period,
    required String status,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "type": "SaveERPEmpAttendancePeriodApp",
      "EmpID": CommonService.employeeId,
      "AttendanceDate":currentDate,
      "Period": period,
      "status": status
    };

    Get.log("attendance save req  : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.EmpAttendanceUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("attendance save req  : ${data.toString()}");
      Get.log("attendance save res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Attendance : ${e.response}");
      EasyLoading.dismiss();
      return false;
    }
  }



}