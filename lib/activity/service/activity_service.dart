import 'dart:io';

import 'package:decora_admin/activity/model/activity_model.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'activity_type.dart';

class ActivityService extends GetxService {
  var activityModel = ActivityModel().obs;

  Future<ActivityModel?> postGetActivityList(
      {required ActivityType type, activityId = "0"}) async {
    // await Future.delayed(Duration(seconds: 3));
    // EasyLoading.show();

    var data={
      "school_code": CommonService.schoolCode,
    "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
    "EmpID": CommonService.employeeId,
    "Type": type.name,
    "ActivityID": activityId
  };
    try {
      final response = await Dio().post(
        EndPoints.activityList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Activity req : ${data.toString()}");
      Get.log("Activity res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return activityModel.value = ActivityModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return activityModel.value = ActivityModel.fromJson(response.data);
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> postSaveActivity({
    required ActivityType type,
    required String activityId,
    required String title,
    required String details,
    required String date,
    required String classIds,
    required bool status,
  }) async {
    EasyLoading.show();
    var data= {
      "school_code": CommonService.schoolCode,
    "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
    "EmpID": CommonService.employeeId,
    "Type": type.name,
    "ActivityID": activityId,
    "ActivityTitle": title,
    "ActivityDetails": details,
    "ActivityDate": date,
    "Status": status?"1":"0",
    "ClassID": classIds
    };
    try {
      final response = await Dio().post(
        EndPoints.activityUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
       data: data,
      );
      Get.log("Activity req : ${data.toString()}");
      Get.log("Activity res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return false;
    }
  }
}
