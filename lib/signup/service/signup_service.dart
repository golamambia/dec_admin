import 'dart:io';

import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../model/signup_model.dart';

class SignupService extends GetxService {
   var signUpModel = SignupModel().obs;


  String schoolCode = "";
  String mobile = "";
  String dob = "";
  String userId = "";

  Future<bool> forgetPassword({
    required String schoolCode,
    required String mobile,
    required String dob,
  }) async {

    this.schoolCode = schoolCode;
    this.mobile = mobile;
    this.dob = dob;

    EasyLoading.show();
    var data={
      "Type": "SchoolForgetPassword",
      "school_code": schoolCode,
      "AdminNoMobile": mobile,
      "DOB": dob
    };

    try {
      Get.log("signUp : call api ${EndPoints.auth}");



      final response = await Dio().post(
        EndPoints.forgetPassword,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("signUp : ${data.toString()}");
      Get.log("signUp : $response");
      EasyLoading.dismiss();

      // Get.log("Upper"
      //     "schoolCode :${this.schoolCode}"
      //     "mobile :${this.mobile}"
      //     "dob :${this.dob}"
      //     "userId :${this.userId}"
      //     "");

      if (response.data["status"]) {
        signUpModel.value = await SignupModel.fromJson(response.data);
        this.userId = signUpModel.value.records?.first.userID ?? "";
        // Get.log("user Id: ${this.userId }");
        return true;
      } else {
        Ams.ft("${response.data["message"]}");
        return false;
      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      return e.response!.data;
    }
  }

  Future<bool> postSignup({
    required String schoolCode,
    required String mobile,
    required String dob,
  }) async {

    this.schoolCode = schoolCode;
    this.mobile = mobile;
    this.dob = dob;

    EasyLoading.show();

    try {
      Get.log("signUp : call api ${EndPoints.auth}");

      var data={
        "Type": "School",
        "school_code": schoolCode,
        "AdminNoMobile": mobile,
        "DOB": dob
      };

      final response = await Dio().post(
        EndPoints.signUp,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data:data ,
      );
      Get.log("signUp : ${data.toString()}");
      Get.log("signUp : $response");
      EasyLoading.dismiss();

      // Get.log("Upper"
      //     "schoolCode :${this.schoolCode}"
      //     "mobile :${this.mobile}"
      //     "dob :${this.dob}"
      //     "userId :${this.userId}"
      //     "");

      if (response.data["status"]) {
        signUpModel.value = await SignupModel.fromJson(response.data);
        this.userId = signUpModel.value.records?.first.userID ?? "";
        // Get.log("user Id: ${this.userId }");
        return true;
      } else {
        Ams.ft("${response.data["message"]}");
        return false;
      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      return e.response!.data;
    }
  }

  Future<bool> verifyOpt({
    required String otp,
  }) async {
    EasyLoading.show();
    //
    Get.log("verify"
        "schoolCode :${this.schoolCode}"
        "mobile :${this.mobile}"
        "dob :${this.dob}"
        "userId :${this.userId}"
        "");

    try {
      Get.log("signUp : call api ${EndPoints.auth}");

      final response = await Dio().post(
        EndPoints.validateOTP,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "Type": "School",
          "school_code": this.schoolCode,
          "UserID": this.userId,
          "OTP":otp
        },
      );
      Get.log("signUp otp : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      return e.response!.data;
    }
  }

  Future<bool> updatePassword({
    required String passCode,
  }) async {
    EasyLoading.show();

    try {
      Get.log("signUp : call api ${EndPoints.auth}");

      final response = await Dio().post(
        EndPoints.updatePassword,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "Type": "School",
          "school_code": this.schoolCode,
          "UserID": this.userId,
          "PassCode":passCode
        },
      );
      Get.log("signUp : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      return e.response!.data;
    }
  }
}
