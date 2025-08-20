import 'dart:io';
import 'dart:math';

import 'package:decora_admin/common/common_service.dart';


import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../util/Ams.dart';
import '../model/online_cls_model.dart';
import 'online_cls_type.dart';

class OnlineClsService extends GetxService {
  var onlineClsModel = OnlineClsModel().obs;
 
  Future<OnlineClsModel> postGetOnlineClsList(
      {required OnlineClsType type}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.OnlineClassList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": type.name,
        },
      );
      Get.log("Home work  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return onlineClsModel.value = OnlineClsModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Home work : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> postSaveOnlineCls(
      {required String title,
      // required String details,
      required String clsIds,
      required String date,
      required bool status,
      required String time,
      required String link,
}) async {
    EasyLoading.show();

    var data= {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": OnlineClsType.SaveOnlineClass.name,
      "OnlineClassID": "0",
      "classDate": date,
      "classTime": time,
      "Status": status==true?"1":"0",
      "title": title,
      "classLink": link,
      "classID": clsIds
    };
    try {
      final response = await Dio().post(
        EndPoints.OnlineClassUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data:data,
      );

      // var d={
      //   "school_code": CommonService.schoolCode,
      //   "SessionID": CommonService.currentSessionId,
 //     "BranchID": CommonService.branchId,
      //   "EmpID": CommonService.employeeId,
      //   "Actiontype":"OnlineCls",
      //   "type":OnlineClsType.SaveOnlineCls.name,
      //   "OnlineClsID":"0",
      //   "PostMode":title,
      //   "PostData":details,
      //   "UploadDate":Ams.getTodayDate(),
      //   "ClassID":clsIds,
      //   "FileType":fType,
      //   "FileData":fData
      // };
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

  Future<bool> postUpdateOnlineCls(
      {required String title,
      required String OnlineClassID,
      required String clsIds,
      required String date,
      required String time,
      required bool status,
      required String link,
}) async {
    EasyLoading.show();

    var data= {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": OnlineClsType.SaveOnlineClass.name,
      "OnlineClassID": OnlineClassID,
      "Status": status==true?"1":"0",
      "classDate": date,
      "classTime": time,
      "title": title,
      "classLink": link,
      "classID": clsIds
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


  Future<bool> postDeleteOnlineCls({
    required String onlineClsId,
  }) async {
    EasyLoading.show();
    Get.log("service Delete");

    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": OnlineClsType.DeleteOnlineClass.name,
      "OnlineClassID": onlineClsId,
    };
    try {

      final response = await Dio().post(
        EndPoints.OnlineClassUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data:data,
      );

      // var d={
      //   "school_code": CommonService.schoolCode,
      //   "SessionID": CommonService.currentSessionId,
      //"BranchID": CommonService.branchId,
      //   "EmpID": CommonService.employeeId,
      //   "Actiontype":"OnlineCls",
      //   "type":OnlineClsType.SaveOnlineCls.name,
      //   "OnlineClsID":onlineClsId,
      //   "PostMode":title,
      //   "PostData":details,
      //   "UploadDate":Ams.getTodayDate(),
      //   "ClassID":clsIds,
      //   "FileType":fType,
      //   "FileData":fData
      // };
      Get.log("Delete : $response");
      Get.log("Delete : ${data.toString()}");
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
