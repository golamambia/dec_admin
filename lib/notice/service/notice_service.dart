import 'dart:io';

import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/notice/model/notice_model.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../bulletin/service/bulletin_service.dart';
import 'notice_type.dart';

class NoticeService extends GetxService {
  var noticeModel = NoticeModel().obs;
  var bulletinService = Get.put(BulletinService());

  Future<NoticeModel> postGetNoticeList(
      {required NoticeType type, noticeId = "0"}) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Type": NoticeType.GetAllNotice.name,
    };
    try {
      final response = await Dio().post(
        EndPoints.noticeList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Notice res : ${data.toString()}");
      Get.log("Notice Get : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return noticeModel.value = NoticeModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> postSaveNotice({
    required NoticeType type,
    required String noticeId,
    required String title,
    required String details,
    required String date,
    required bool status,
    required String classIds,
    required String fileData,
    required String fileType,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "Actiontype": "Notice",
      "type": type.name,
      "NoticeID": noticeId,
      "NoticeTitle": title,
      "NoticeDetails": details,
      "NoticeDate": date,
      "FileType": fileType,
      "Status": status ? "1" : "0",
      "ClassID": classIds,
      "FileData": fileData,
    };
    try {
      final response = await Dio().post(
        EndPoints.noticeUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Notice save req : ${data.toString()}");
      Get.log("Notice save res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        bulletinService.sendBulletinForAll(
            title: title, clsIds: classIds, msgBody: details);
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }
}
