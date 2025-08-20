import 'dart:io';

import 'package:decora_admin/common/model/employee_model.dart';
import 'package:decora_admin/common/model/student_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';

class ChatService extends GetxService{

  var teacherModel=StudentModel(records: []).obs;

  @override
  void onInit() {
    // getChatEmployeeList();
    super.onInit();
  }

  Future<StudentModel> getChatStudentList({
    required clsId
}) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "type": "StudentList",
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "ClassID":clsId
    };
    try {
      final response = await Dio().post(
        EndPoints.ChatEmpList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("chat req  : ${data.toString()}");
      Get.log("chat res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return teacherModel.value =
            StudentModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["bulletin"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Bulletin res : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> saveChat({
    required msg,
    required roomId,
    required stuId,
    required senderId,
  }) async {
    // EasyLoading.show();
    var data={
      "school_code":CommonService.schoolCode,
      "type": "InsertRoomMessage",
      "BranchID":CommonService.branchId,
      "RoomID":roomId,
      "Message":msg,
      "EmpID":CommonService.employeeId,
      "ST_ID":stuId,
      "UserID":senderId

    };
    try {
      final response = await Dio().post(
        EndPoints.EditChat,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("chat save req  : ${data.toString()}");
      Get.log("chat save res  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Bulletin res : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

}