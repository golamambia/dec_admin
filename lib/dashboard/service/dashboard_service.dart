import 'dart:io';

import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/splash/SplashPage.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../model/dashboard_model.dart';

class DashboardService extends GetxService {
  var dashboardModel = DashboardModel(footer: []).obs;

  @override
  void onInit() {
    postDashboard();
    super.onInit();
  }

  Future<DashboardModel> postDashboard() async {
    // EasyLoading.show();
    var data = {
      "type": "GetSchoolDashboard",
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Emp_TypeID": CommonService.employeeTypeId
    };
    try {
      final response = await Dio().post(
        EndPoints.dashboard,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Dashboard req : $data");
      Get.log("Dashboard : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return dashboardModel.value = DashboardModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }

      // return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      // return e.response!.data;
    }
    return dashboardModel.value;
  }

  Future<void> postSwitchBranch() async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.dashboard,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId
        },
      );
      Get.log("Dashboard : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        dashboardModel.value = DashboardModel.fromJson(response.data);
        Ams.ft("${response.data["message"]}");
        Get.off(() => SplashPage());
      } else {
        Ams.ft("${response.data["message"]}");
      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }
}
