import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:decora_admin/common/model/class_list.dart';
import 'package:decora_admin/common/model/employee_model.dart';
import 'package:decora_admin/common/model/student_model.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../util/end_points.dart';

enum LocalDataType {
  employeeId,
  branchCode,
  userId,
  branchId,
  mobile,
  schoolCode,
  localPin,
  currentSessionId,
  employeeTypeId
}

class CommonService extends GetxService {
  static String employeeId = "";
  static String branchCode = "";
  static String branchId = "";
  static String userId = "";
  static String mobile = "";
  static String schoolCode = "";
  static String localPin = "";
  static String  currentSessionId="";
  static String employeeTypeId = "";
  static Rx<ClassList> classList = ClassList(records: []).obs;
  static Rx<EmployeeModel> empList = EmployeeModel(records: []).obs;

  @override
  void onInit() {
    employeeId = getStringAsync("employeeId", defaultValue: "");
    branchCode = getStringAsync("branchCode", defaultValue: "");
    userId = getStringAsync("userId", defaultValue: "");
    branchId = getStringAsync("branchId", defaultValue: "");
    mobile = getStringAsync("mobile", defaultValue: "");
    schoolCode = getStringAsync("schoolCode", defaultValue: "");
    localPin = getStringAsync("localPin", defaultValue: "");
    currentSessionId = getStringAsync("currentSessionId", defaultValue: "");
    employeeTypeId = getStringAsync("employeeTypeId", defaultValue: "");

    Get.log("schoolCode: $schoolCode");
    Get.log("employeeId: $employeeId");
    Get.log("branchCode: $branchCode");
    Get.log("userId: $userId");
    Get.log("branchId: $branchId");
    Get.log("mobile: $mobile");
    Get.log("localPin: $localPin");
    Get.log("currentSessionId: $currentSessionId");
    Get.log("employeeTypeId: $employeeTypeId");

    postClassList();
    super.onInit();
  }

  static Future<void> getAllLocalData() async {
    employeeId = getStringAsync("employeeId", defaultValue: "");
    branchCode = getStringAsync("branchCode", defaultValue: "");
    userId = getStringAsync("userId", defaultValue: "");
    branchId = getStringAsync("branchId", defaultValue: "");
    mobile = getStringAsync("mobile", defaultValue: "");
    schoolCode = getStringAsync("schoolCode", defaultValue: "");
    localPin = getStringAsync("localPin", defaultValue: "");
    currentSessionId = getStringAsync("currentSessionId", defaultValue: "");
    employeeTypeId = getStringAsync("employeeTypeId", defaultValue: "");

    Get.log("schoolCode: $schoolCode");
    Get.log("employeeId: $employeeId");
    Get.log("branchCode: $branchCode");
    Get.log("userId: $userId");
    Get.log("branchId: $branchId");
    Get.log("mobile: $mobile");
    Get.log("localPin: $localPin");
    Get.log("currentSessionId: $currentSessionId");
    Get.log("employeeTypeId: $employeeTypeId");

  }

  static Future<void> saveAllVale(
      {String employeeId = "",
      String branchCode = "",
      String userId = "",
      String branchId = "",
      String mobile = "",
      String schoolCode = "",
      String localPin = "",
      String currentSessionId = "",
      String employeeTypeId = ""}) async {
    await setValue("employeeId", employeeId, print: true);
    await setValue("branchCode", branchCode, print: true);
    await setValue("userId", userId, print: true);
    await setValue("mobile", mobile, print: true);
    await setValue("schoolCode", schoolCode, print: true);
    await setValue("localPin", localPin, print: true);
    await setValue("currentSessionId", currentSessionId, print: true);
    await setValue("employeeTypeId", employeeTypeId, print: true);
    await setValue("branchId", branchId, print: true);

    getAllLocalData();

  }

  static void saveIndividualValue(
      {required String value, required LocalDataType type}) async {
    await setValue(type.name, value, print: true);
  }

  Future<ClassList> postClassList() async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.classList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "type": "GetAllClassMst",
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId
        },
      );
      Get.log("classList : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return classList.value = ClassList.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      // return e.response!.data;
    }
    return classList.value;
  }

  Future<EmployeeModel> postEmployeeList() async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.EmpList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "Type": "GetAllEmployee_Active",
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
        },
      );
      Get.log("classList : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return  empList.value=EmployeeModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      // return e.response!.data;
    }
    return empList.value;
  }



  static List<ClassRecord> classRecordFromClsId(String clsIds) {
    var split = clsIds.split(",");
    List<ClassRecord> clsList = [];
    split.forEach((clsId) {
      CommonService.classList.value.records.forEach((clsRecord) {
        if (clsRecord.classID.equalsIgnoreCase(clsId)) {
          clsList.add(clsRecord);
        }
      }
      );
    },);
    return clsList;
  }
  static List<ClassRecord> classRecordFromClsName(String clsName) {
    var split = clsName.split(",");
    List<ClassRecord> clsList = [];
    split.forEach((clsName) {
      CommonService.classList.value.records.forEach((clsRecord) {
        if (clsRecord.className.equalsIgnoreCase(clsName)) {
          clsList.add(clsRecord);
        }
      }
      );
    },);
    return clsList;
  }
}
