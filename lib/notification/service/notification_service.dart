import 'dart:io';

import 'package:decora_admin/bulletin/service/bulletin_type.dart';
import 'package:decora_admin/notification/model/notification_model.dart';
import 'package:decora_admin/notification/model/notification_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';

class NotificationService extends GetxService {
  var notificationModel = NotificationModel(records: []).obs;

  Future<NotificationModel> getNotificationList() async {
    var data = {
      "type": NotificationType.GetBulletinByTypeApp.name,
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "UserID": CommonService.employeeId,
      "SendType": SenderType.Teacher.name,
    };
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.NotificationList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("notification req  : ${data.toString()}");
      Get.log("notification res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return notificationModel.value =
            NotificationModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Message res : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }
}
