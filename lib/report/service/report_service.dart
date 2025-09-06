 import 'dart:io';
import 'dart:math';

import 'package:decora_admin/common/common_service.dart';


import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../../util/Ams.dart';
 

class ReportService extends GetxService {

Future<bool> postDownloadReport3({
  required String fromDate,
  required String toDate, String? type,
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


 Future<bool> postDownloadReport(
      {required String fromDate,
      required String toDate,
     String? type,
 
}) async {
    EasyLoading.show();
String formattedFromDate =
      DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(fromDate));
  String formattedToDate =
      DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(toDate));
    var data= {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
 
"SP": "Notification",
"type": type,
 
"CreatedBy": "",
"Class": "",
"From_date": formattedFromDate,
    "To_date": formattedToDate,
"UserID": "",
"ExamId": "",
"Date": "",
"SubjectID": "",
"MobileNo": "",
"ClassID": "",
"InstallmentID": "",
"CurDate": ""
 
    };
    try {
      final response = await Dio().post(
        EndPoints.ReportDownloadInfo,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data:data,
      );
  
  print("Decoded Data: $response");

      Get.log("ReportDownloadInfo : $response");
      Get.log("ReportDownloadInfo : ${data.toString()}");
      EasyLoading.dismiss();
 
      if (response.data["status"]) {
        String fileUrl = "https://newappapi.decorainfotech.in${response.data["message"]}";
  await downloadReport(fileUrl);
        Ams.ft("Report downloaded successfully");
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

Future<void> downloadReport(String fileUrl) async {
  try {
    var dio = Dio();

    // Get app's document directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String savePath = "${appDocDir.path}/report.xlsx";

    // Start download
    await dio.download(
      fileUrl,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print("Download Progress: ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
    );

    print("File saved at: $savePath");
  } catch (e) {
    print("Download error: $e");
  }
}

}