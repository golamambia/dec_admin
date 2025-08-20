import 'dart:io';
import 'dart:math';

import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../bulletin/service/bulletin_service.dart';
import '../../util/Ams.dart';
import '../model/assignment_model.dart';
import 'assignment_type.dart';

class AssignmentService extends GetxService {
  var assignmentModel = AssignmentModel().obs;
  var assignmentClassList = AssignmentModel().obs;
  var assignmentByClassModel = AssignmentModel().obs;
  var bulletinService = Get.put(BulletinService());



  Future<AssignmentModel> postGetAssignmentList(
      {required AssignmentType type}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.AssignmentList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "type": AssignmentType.GetAllAssignment.name,
          "AssignmentID":""

        },
      );
      Get.log("Assignment  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return assignmentModel.value = AssignmentModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Assignment : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<AssignmentModel> getAssignmentClassList(
      {required assignmentId}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.AssignmentList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "type": AssignmentType.GetClassByAssignmentID.name,
          "AssignmentID":assignmentId

        },
      );
      Get.log("Assignment  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return assignmentClassList.value = AssignmentModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Assignment : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<AssignmentModel> getAssignmentByClassId(
      {required String clsId,required String assignmentId}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.AssignmentList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "type": AssignmentType.GetAllAssignmentByStudentSubmittedForTeacher.name,
          "ClassID":clsId,
          "AssignmentID":assignmentId

        },
      );
      Get.log("Assignment  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return assignmentByClassModel.value = AssignmentModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Assignment : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> postSaveAssignment(
      {required String title,
      required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.AssignmentUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Actiontype": "Assignment",
          "type": AssignmentType.SaveAssignment.name,
          "AssignmentID": "0",
          "Title": title,
          // "PostData": details,
          "UploadDate": Ams.getTodayDate(),
          "ClassID": clsIds,
          "FileType": fType,
          "FileData": fData
        },
      );

      // var d={
      //   "school_code": CommonService.schoolCode,
      //   "SessionID": CommonService.currentSessionId,
 //     "BranchID": CommonService.branchId,
      //   "EmpID": CommonService.employeeId,
      //   "Actiontype":"Assignment",
      //   "type":AssignmentType.SaveAssignment.name,
      //   "AssignmentID":"0",
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
        Ams.ft("Saved assignment successfully");
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

  Future<bool> postUpdateAssignment(
      {required String assignmentId,
      required String title,
      required String details,
      required String clsIds,
      required String uploadDate,
      required String fType,
      required String fData}) async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.AssignmentUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Actiontype": "Assignment",
          "type": AssignmentType.UpdateAssignment.name,
          "AssignmentID": assignmentId,
          "Title": title,
          // "PostData": details,
          "UploadDate": Ams.getTodayDate(),
          "ClassID": clsIds,
          "FileType": fType,
          "FileData": fData
        },
      );

      // var d={
      //   "school_code": CommonService.schoolCode,
      //   "SessionID": CommonService.currentSessionId,
 //     "BranchID": CommonService.branchId,
      //   "EmpID": CommonService.employeeId,
      //   "Actiontype":"Assignment",
      //   "type":AssignmentType.SaveAssignment.name,
      //   "AssignmentID":assignmentId,
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
        Ams.ft("Saved assignment successfully");
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

  Future<bool> postDeleteAssignment({
    required String assignmentId,
  }) async {
    EasyLoading.show();
    Get.log("service Delete");

    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Actiontype": "Assignment",
      "type": AssignmentType.DeleteAssignment.name,
      "AssignmentID": assignmentId,
      "FileData":""
    };
    try {

      final response = await Dio().post(
        EndPoints.AssignmentUpdate,
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
      //   "Actiontype":"Assignment",
      //   "type":AssignmentType.SaveAssignment.name,
      //   "AssignmentID":assignmentId,
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
        Ams.ft("Saved assignment successfully");
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
