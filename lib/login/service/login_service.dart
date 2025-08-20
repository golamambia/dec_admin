import 'dart:io';

import 'package:decora_admin/login/model/login_model.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginService extends GetxService {
  LoginModel? loginModel = LoginModel();

  Future<dynamic> postLogin(
      {required String schoolCode,
      required String mobile,
      required String password}) async {

    var token = await FirebaseMessaging.instance.getToken();
    Get.log("DeviceToken:  ${token}");

    EasyLoading.show();

    try {
      Get.log("login : call api ${EndPoints.auth}");

      final response = await Dio().post(
        EndPoints.login,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": schoolCode,
          "AdminNoMobile": mobile,
          "Password": password,
          "DeviceType": Platform.isAndroid ? "Android" : "IOS",
          "DeviceToken": token
        },
      );
      Get.log("login : $response");
      EasyLoading.dismiss();


      if (response.data["status"]) {
        return loginModel = LoginModel.fromJson(response.data);
      } else {
        Ams.ft("${response.data["message"]}");
      }

      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      return e.response!.data;
    }
  }
}
