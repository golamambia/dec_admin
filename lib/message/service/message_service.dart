import 'dart:io';
import 'package:decora_admin/message/controller/message_controller.dart';
import 'package:decora_admin/message/model/message_model.dart';
import 'package:decora_admin/message/service/message_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';
import '../../util/objectDetails.dart';

class MessageService extends GetxService{

  var messageModel=MessageModel(records: []).obs;

  @override
  void onInit() {
    getMessageList();
    super.onInit();
  }

  Future<MessageModel> getMessageList() async {
    EasyLoading.show();
    try {
      final response = await Dio().post(
        EndPoints.MessageTitle,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: {
          "school_code": CommonService.schoolCode,
          "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
          "EmpID": CommonService.employeeId,
          "Type": MessageType.GetMessageTitle.name,
        },
      );
      Get.log("message res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return messageModel.value =
            MessageModel.fromJson(response.data);
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

  Future<bool> sendMessage({
    required String type,
    required String message,
    required String templateId,
    required String deliveryMobileNo,
    required String clsIds,
    required List? objDetailsList
  }) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "Type": type,
      "TempleteID":templateId,
      "Message":message,
      "ClassID":clsIds,
      "CreatedBy":CommonService.employeeId,
      "DeliveryMobileNo":deliveryMobileNo,
      "ObjDetails":objDetailsList??[]
    };
    Get.log("message req  : ${data.toString()}");
    EasyLoading.dismiss();

    try {
      final response = await Dio().post(
        EndPoints.UpdateMessage,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("message res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;

      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Message res : ${e.response}");
      EasyLoading.dismiss();
      return false;
    }
  }

}