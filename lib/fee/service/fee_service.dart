import 'dart:io';

import 'package:decora_admin/fee/model/fee_model.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/model/student_search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';
import 'fee_type.dart';

class FeeService extends GetxService {
  static var installmentModel = InstallmentModel(records: []).obs;
  var feeModel = FeeModel().obs;
  var studentModel = StudentSearchModel().obs;

  @override
  void onInit() {
    getInstallmentList();
    super.onInit();
  }

  //getting all installment record
  Future<InstallmentModel> getInstallmentList() async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.InstallmentList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": FeeType.GetAllInstallment.name,
        },
      );
      Get.log("fee res  : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return installmentModel.value =
            InstallmentModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      // Get.log("Home work : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<StudentSearchModel> getStudentSearchList(
      {required String searchItem}) async {
    // EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.SearchStudentList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "SearchItem": searchItem,
          "Type": FeeType.GetStudentSearch.name,
        },
      );
      Get.log("fee std res : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return studentModel.value = StudentSearchModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      // Get.log("Home work : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  //either stdId or classIds must be provide
  Future<FeeModel> getFeeList({
    required String installmentID,
    String stdId="0",
     String classIds="0",
     required FeeType type,
    required String currentDate,
}) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Type": type.name,
      "InstallmentID":installmentID,
      "ClassID":classIds,
      "ST_ID":stdId,
      "CurDate":currentDate
    };
    try {
      final response = await Dio().post(
        EndPoints.FeeList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("fee Req  : ${data.toString()}");
      Get.log("fee Res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return feeModel.value = FeeModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      // Get.log("Home work : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }
}
