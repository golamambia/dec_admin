import 'dart:io';

import 'package:decora_admin/mark/model/mark_info_model.dart';
import 'package:decora_admin/mark/model/student_mark_model.dart';
import 'package:decora_admin/mark/service/mark_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';

class MarkService extends GetxService {
  var subjectInfoModel = MarkInfoModel().obs;
  var examInfoModel = MarkInfoModel().obs;
  var studentMarkModel = StudentMarkModel().obs;

  Future<MarkInfoModel> subjectList({required String clsId}) async {
    subjectInfoModel.value=MarkInfoModel();
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": MarkType.SelectSubject.name,
      "ClassID": clsId,
      // "SubjectID":"0",
      // "ExamID":"0"
    };
    try {
      final response = await Dio().post(
        EndPoints.MarksInfo,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Mark  Subject : ${data.toString()}");
      Get.log("Mark  Subject : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return subjectInfoModel.value = MarkInfoModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Mark Subject : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<MarkInfoModel> examList({
    required String clsId,
    required String subId,
  }) async {
    examInfoModel.value=MarkInfoModel();
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": MarkType.SelectExam.name,
      "ClassID": clsId,
      "SubjectID": subId,
      // "ExamID":"0"
    };
    try {
      final response = await Dio().post(
        EndPoints.MarksInfo,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data
      );
      Get.log("Mark  Exam req : ${data.toString()}");
      Get.log("Mark  Exam : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return examInfoModel.value = MarkInfoModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Mark Exam : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<StudentMarkModel> studentList({
    required String clsId,
    required String subId,
    required String examId,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": MarkType.SelectStudent.name,
      "ClassID": clsId,
      "SubjectID": subId,
      "ExamID":examId
    };
    try {
      final response = await Dio().post(
        EndPoints.MarksList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Student   Mark  req: ${data.toString()}");
      Get.log("Student   Mark : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return studentMarkModel.value = StudentMarkModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Student  Mark : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> saveStudentMark({
    required String clsId,
    required String subId,
    required String examId,
    required String maxMark,
    required String saveType ,
    required List<StudentMarkRecords>? objStudentMarkRecordeList ,
  }) async {
    EasyLoading.show();
    var list = studentMarkModel.value.school?.map((e) => {
      "ST_ID":e.sT_ID,
      "Mark":e.marks,
      "Grade":e.grade
    }).toList();

    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": saveType,
      "ClassID": clsId,
      "SubjectID": subId,
      "ExamID":examId,
      "MaxMarks":maxMark,
      "objStudetnMarksModel":list
    };
    try {
      final response = await Dio().post(
        EndPoints.MarksUpdate,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Save mark req: ${data.toString()}");
      Get.log("Save mark res: $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        // Ams.ft("${response.data["message"]}");
        return false;
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Student  Mark : ${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
  }


}
