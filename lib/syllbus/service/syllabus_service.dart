import 'dart:io';
import 'dart:math';

import 'package:decora_admin/common/common_service.dart';

import 'package:decora_admin/syllbus/model/syllabus_model.dart';
import 'package:decora_admin/syllbus/service/syllabus_type.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../bulletin/service/bulletin_service.dart';
import '../../util/Ams.dart';

class SyllabusService extends GetxService {
  var syllabusModel = SyllabusModel().obs;

  var bulletinService = Get.put(BulletinService());


  Future<SyllabusModel> postGetSyllabusList(
      {required SyllabusType type}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.SyllabusList,
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
      Get.log("Syllabus  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return syllabusModel.value = SyllabusModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Syllabus : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> postSaveSyllabus(
      {required String title,
      // required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.SyllabusUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Actiontype": "Syllabus",
          "type": SyllabusType.SaveSyllabus.name,
          "SyllabusID": "0",
          "Title": title,
          // "PostData": details,
          "UploadDate": Ams.getTodayDate(),
          "ClassID": clsIds,
          "FileType": fType,
          "FileData": fData
        },
      );

     var dat= {
        "school_code": CommonService.schoolCode,
    "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
    "EmpID": CommonService.employeeId,
    "Actiontype": "Syllabus",
    "type": SyllabusType.SaveSyllabus.name,
    "SyllabusID": "0",
    "Title": title,
    // "PostData": details,
    "UploadDate": Ams.getTodayDate(),
    "ClassID": clsIds,
    "FileType": fType,
    "FileData": fData
  };


      Get.log("save Syllabus req : ${dat.toString()}");
      Get.log("save Syllabus : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        Ams.ft("Saved syllabus successfully");
        bulletinService.sendBulletinForAll(title: title, clsIds: clsIds, msgBody: "");
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

  Future<bool> postUpdateSyllabus(
      {required String syllabusId,
      required String title,
      // required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.SyllabusUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Actiontype": "Syllabus",
          "type": SyllabusType.UpdateSyllabus.name,
          "SyllabusID": syllabusId,
          "Title": title,
          // "PostData": details,
          "UploadDate": Ams.getTodayDate(),
          "ClassID": clsIds,
          "FileType": fType,
          "FileData": fData
        },
      );

      var d={
        "school_code": CommonService.schoolCode,
        "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
        "EmpID": CommonService.employeeId,
        "Actiontype": "Syllabus",
        "type": SyllabusType.UpdateSyllabus.name,
        "SyllabusID": syllabusId,
        "Title": title,
        // "PostData": details,
        "UploadDate": Ams.getTodayDate(),
        "ClassID": clsIds,
        "FileType": fType,
        "FileData": fData
      };
      Get.log("update Syllabus : $response");
      Get.log("update Syllabus : ${d.toString()}");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        Ams.ft("Saved syllabus successfully");
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

  Future<bool> postDeleteSyllabus({
    required String syllabusId,
  }) async {
    EasyLoading.show();
    Get.log("service Delete");

    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Actiontype": "Syllabus",
      "type": SyllabusType.DeleteSyllabus.name,
      "SyllabusID": syllabusId,
      "FileData":""
    };
    try {

      final response = await Dio().post(
        EndPoints.SyllabusUpdate,
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
      //   "Actiontype":"Syllabus",
      //   "type":SyllabusType.SaveSyllabus.name,
      //   "SyllabusID":syllabusId,
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
        Ams.ft("Saved syllabus successfully");
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
