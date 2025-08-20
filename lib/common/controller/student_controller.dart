import 'dart:developer';
import 'dart:io';

import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/service/fee_service.dart';
import 'package:decora_admin/message/service/message_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../model/student_model.dart';
import '../../util/end_points.dart';
import '../common_service.dart';
import '../model/class_list.dart';

class StudentController extends GetxController{

  var studentModel=StudentModel(records: []).obs;

  Future<StudentModel> getStudentsList({
    required String clsIds
}) async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "ClassID":clsIds,
      "Type":"GetStudentbyClass"
    };
    try {
      final response = await Dio().post(
        EndPoints.StudentByClass,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Students req  : ${data.toString()}");
      Get.log("Students res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return studentModel.value =
            StudentModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Student res : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }




  var isSelectAllStudent = false.obs;

  var selectedStudentList = List<StudentRecord>.empty(growable: true).obs;
  // var initailCls = List<StudentRecord>.empty(growable: true).obs;

  var studentsIds = "".obs;

  //on all installment toggle switch
  void onStudentListSwitchChange(){
    if(isSelectAllStudent.value) {
      selectedStudentList.value = List.of(studentModel.value.records!,growable: true);
      studentsIds.value = selectedStudentList.map((e) => e.sT_ID).join(",");
      selectedStudentList.refresh();
      log("selected: "+selectedStudentList.toString());
    }else{
      selectedStudentList.value=[];
      studentsIds.value="";
    }
    selectedStudentList.refresh(); // Trigger UI refresh
    Get.log("Selected Student: ${selectedStudentList.length}");
  }

  onConfirm(List<StudentRecord> list) {
    selectedStudentList.value = list;
    studentsIds.value = selectedStudentList.map((e) => e.sT_ID).toList().join(",");
    isSelectAllStudent.value = list.length == studentModel.value.records!.length;
    selectedStudentList.refresh();
  }
}