import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';
import '../../util/objectDetails.dart';
import '../model/bulletin_model.dart';
import 'bulletin_type.dart';

class BulletinService extends GetxService{

  var bulletinModel=BulletinModel().obs;

  @override
  void onInit() {
    getBulletinList();
    super.onInit();
  }

  Future<BulletinModel> getBulletinList() async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.BulletinUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          // "Type": BulletinType.GetBulletinTitle.name,
        },
      );
      Get.log("bulletin res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return bulletinModel.value =
            BulletinModel.fromJson(response.data);
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

  Future<BulletinModel> sendBulletin({
    required BulletinType type,
    required String userIds,
    required SenderType senderType,
    required String title,
    required String clsIds,
    required String msgBody
  }) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID":CommonService.employeeId,
      "UserID":userIds,
      "SendType":senderType.name,
      "type":type.name,
      "ClassID":clsIds,
      "Title":title,
      "MsgBody":msgBody
    };

    try {
      final response = await Dio().post(
        EndPoints.BulletinUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("bulletin req  : ${data.toString()}");
      Get.log("bulletin res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return bulletinModel.value =
            BulletinModel.fromJson(response.data);
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

  Future<bool> sendBulletinForAll({
    required String title,
    required String clsIds,
    required String msgBody
  }) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID":CommonService.employeeId,
      "UserID":"",
      "SendType":SenderType.Class.name,
      "type":BulletinType.SaveBulletin.name,
      "ClassID":clsIds,
      "Title":title,
      "MsgBody":msgBody
    };

    try {
      final response = await Dio().post(
        EndPoints.BulletinUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("bulletin req  : ${data.toString()}");
      Get.log("bulletin res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["bulletin"]}");
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