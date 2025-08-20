 import 'dart:io';
import 'dart:math';

import 'package:decora_admin/common/common_service.dart';


import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../util/Ams.dart';
 

class ReportService extends GetxService {

Future<bool> postDownloadReport({
  required String fromDate,
  required String toDate,
}) async {
  EasyLoading.show(status: "Downloading...");

  var data = {
    "school_code": CommonService.schoolCode,
    "SessionID": CommonService.currentSessionId,
    "BranchID": CommonService.branchId,
    "EmpID": CommonService.employeeId,
    "FromDate": fromDate,
    "ToDate": toDate,
    "OnlineClassID": "0",
  };

  try {
    // 🟢 Just log data instead of API call
    Get.log("📤 Sending report request: $data");

    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    EasyLoading.dismiss();
    Ams.ft("Saved successfully");
    return true;
  } on DioException catch (e) {
    // Get.log("❌ Dio Error: ${e.response}");
    Ams.ft("Not saved!!!");
    EasyLoading.dismiss();
    return false;
  } catch (e) {
    // Get.log("❌ Unexpected error: $e");
    Ams.ft("Something went wrong");
    EasyLoading.dismiss();
    return false;
  }
}


 Future<bool> postDownloadReport2(
      {required String fromDate,
      required String toDate
 
}) async {
    EasyLoading.show();

    var data= {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
       
      "OnlineClassID": "0",
 
    };
    try {
      final response = await Dio().post(
        EndPoints.OnlineClassUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data:data,
      );
 
      Get.log("update OnlineCls : $response");
      Get.log("update OnlineCls : ${data.toString()}");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        Ams.ft("Saved Online Class successfully");
        return true;
      } else {
        Ams.ft("${response.data["message"]}");
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      Ams.ft("Not saved!!!");
      EasyLoading.dismiss();
      return false;
    }
    return false;
  }



}