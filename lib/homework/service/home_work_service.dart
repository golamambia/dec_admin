import 'dart:io';
import 'dart:math';

import 'package:decora_admin/bulletin/service/bulletin_service.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/homework/service/home_work_type.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../util/Ams.dart';

class HomeWorkService extends GetxService {
  var homeWorkModel = HomeWorkModel().obs;
  var homeWorkByClassModel = HomeWorkModel().obs;
  var homeWorkClassList = HomeWorkModel().obs;
  var bulletinService = Get.put(BulletinService());

  Future<HomeWorkModel> postGetHomeWorkList(
      {required HomeWorkType type}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.HomeWorkList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": HomeWorkType.GetAllHomework.name,
        },
      );
      Get.log("Home work  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return homeWorkModel.value = HomeWorkModel.fromJson(response.data);
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

  Future<HomeWorkModel> getHomeWorkByClassId(
      {required String clsId, String? homeWorkId}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.HomeWorkList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": HomeWorkType.GetAllHomeWorkByStudentSubmittedForTeacher.name,
          "ClassID":clsId,
          "HomeWorkID":homeWorkId
        },
      );
      Get.log("Home work  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return homeWorkByClassModel.value = HomeWorkModel.fromJson(response.data);
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

  Future<HomeWorkModel> getHomeWorkClassList(
      {required String homeWorkId}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.HomeWorkList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": HomeWorkType.GetClassByHomeWorkID.name,
          "HomeworkID":homeWorkId
        },
      );
      Get.log("Home work  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return homeWorkClassList.value = HomeWorkModel.fromJson(response.data);
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

  Future<bool> postSaveHomeWork(
      {required String title,
      required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Actiontype": "HomeWork",
      "type": HomeWorkType.SaveHomeWork.name,
      "HomeworkID": "0",
      "PostMode": title,
      "PostData": details,
      "UploadDate": Ams.getTodayDate(),
      "ClassID": clsIds,
      "FileType": fType,
      "FileData": fData
    };
    try {
      final response = await Dio().post(
        EndPoints.HomeWorkUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );


      Get.log("saveHome req  : ${data.toString()}");
      Get.log("saveHome  res: $response");
      // Get.log("saveHome : ${d.toString()}");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        Ams.ft("Saved homework successfully");
        bulletinService.sendBulletinForAll(title: title, clsIds: clsIds, msgBody: details);
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

  Future<bool> postUpdateHomeWork(
      {required String homeWorkId,
      required String title,
      required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.HomeWorkUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Actiontype": "HomeWork",
          "type": HomeWorkType.UpdateHomework.name,
          "HomeworkID": homeWorkId,
          "PostMode": title,
          "PostData": details,
          "UploadDate": Ams.getTodayDate(),
          "ClassID": clsIds,
          "FileType": fType,
          "FileData": fData
        },
      );

      // var d={
      //   "school_code": CommonService.schoolCode,
      //   "SessionID": CommonService.currentSessionId,
      //"BranchID": CommonService.branchId,
      //   "EmpID": CommonService.employeeId,
      //   "Actiontype":"HomeWork",
      //   "type":HomeWorkType.SaveHomeWork.name,
      //   "HomeworkID":homeWorkId,
      //   "PostMode":title,
      //   "PostData":details,
      //   "UploadDate":Ams.getTodayDate(),
      //   "ClassID":clsIds,
      //   "FileType":fType,
      //   "FileData":fData
      // };
      Get.log("saveHome : $response");
      // Get.log("saveHome : ${d.toString()}");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        Ams.ft("Saved homework successfully");
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

  Future<bool> postDeleteHomeWork({
    required String homeWorkId,
  }) async {
    EasyLoading.show();
    Get.log("service Delete");

    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Actiontype": "HomeWork",
      "type": HomeWorkType.DeleteHomework.name,
      "HomeworkID": homeWorkId,
      "FileData":""
    };
    try {

      final response = await Dio().post(
        EndPoints.HomeWorkUpdate,
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
      //   "Actiontype":"HomeWork",
      //   "type":HomeWorkType.SaveHomeWork.name,
      //   "HomeworkID":homeWorkId,
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
        Ams.ft("Saved homework successfully");
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
