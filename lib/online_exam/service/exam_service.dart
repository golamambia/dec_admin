import 'dart:io';

import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/model/paper_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../util/end_points.dart';

class ExamService extends GetxService {
  var examModel = ExamModel().obs;
  var examClsList = ExamModel().obs;
  var examSubList = ExamModel().obs;
  var mcqPaperModel = PaperModel().obs;
  var desPaperModel = PaperModel().obs;

  Future<ExamModel> getExamList({required ExamType type}) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": type.name,
    };
    Get.log("Exam List res : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.ExamList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam List res : ${data.toString()}");
      Get.log("Exam List Get : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return examModel.value = ExamModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
    return ExamModel();
  }

  Future<bool> saveExam(
      {required ExamType type,
      examId = "0",
      required String examName,
      required String fromDate,
      required String toDate,
      required String isResult,
      required String clsIds}) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": type.name,
      "ExamID": examId,
      "Exam": examName,
      "ExamDateFrom": fromDate,
      "ExamDateTo": toDate,
      "IsResult": isResult,
      "ClassID": clsIds,
    };
    Get.log("Exam Save req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdateExam,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Save req : ${data.toString()}");
      Get.log("Exam Save res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> deleteExam({
    examId = "0",
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": "DeleteOnlineExamApp",
      "ExamID": examId,
    };
    Get.log("Exam Save req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdateExam,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Save req : ${data.toString()}");
      Get.log("Exam Save res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<ExamModel> getExamClassList({required String examId}) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": ExamType.GetExamClassByID.name,
      "ExamID": examId
    };
    Get.log("Exam cls List req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.ExamList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam cls List req : ${data.toString()}");
      Get.log("Exam cls List res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return examClsList.value = ExamModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.error}");
      EasyLoading.dismiss();
      Get.log("${e.response?.data ?? ""}");
    }
    return ExamModel();
  }

  Future<ExamModel> getExamSubList({
    required String examId,
    required String clsId,
    required String subId,
  }) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": "GetExamClassSubjectMapping",
      "ExamID": examId,
      "ClassID": clsId,
      "SubjectID": subId
    };
    try {
      final response = await Dio().post(
        EndPoints.ExamList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Sub List req : ${data.toString()}");
      Get.log("Exam Sub List Get : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return examSubList.value = ExamModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
    return ExamModel();
  }

  Future<bool> saveExamSubject({
    required ExamType type,
    onlineSubId = "0",
    required String examId,
    required String subId,
    required String clsId,
    required String examDate,
    required String objCount,
    required String objMarks,
    required String desCount,
    required String desMarks,
    required String timeIn,
    required String timeOut,
    required String passMark,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": type.name,
      "OnlineExamClassSubjectMappID": onlineSubId,
      "ExamID": examId,
      "ClassID": clsId,
      "SubjectID": subId,
      "ExamDate": examDate,
      "TimeIn": timeIn,
      "TimeOut": timeOut,
      "ObjQuesNo": objCount,
      "ObjQuesMarks": objMarks,
      "DesQuesNo": desCount,
      "DesQuesMarks": desMarks,
      "PassMarks": passMark
    };
    Get.log("Exam Subject req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdateExam,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Save req : ${data.toString()}");
      Get.log("Exam Save res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> deleteExamSubject(
      {onlineSubId = "0"}) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "OnlineExamClassSubjectMappID": onlineSubId,
      "type": "DeleteExamClassSubjectMappingApp",
    };
    Get.log("Exam Subject req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdateExam,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Save req : ${data.toString()}");
      Get.log("Exam Save res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  // ===========================================================

  Future<PaperModel> getMcqQuestion({
    required String examId,
    required String clsId,
    required String subId,
  }) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": "GetAllObjecttiveQuestions",
      "ExamID": examId,
      "ClassID": clsId,
      "SubjectID": subId
    };
    try {
      final response = await Dio().post(
        EndPoints.QuestionList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Mcq List req : ${data.toString()}");
      Get.log("Exam Mcq List Get : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return mcqPaperModel.value = PaperModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
    return PaperModel();
  }

  Future<bool> saveMcq({
    String QuestionID = "0",
    required ExamType type,
    required String ExamID,
    required String ClassID,
    required String SubjectID,
    required String Question,
    required String QuestionFile,
    required String QuestionFileData,
    required String Choice1,
    required String Choice1File,
    required String Choice1FileData,
    required String Choice2,
    required String Choice2File,
    required String Choice2FileData,
    required String Choice3,
    required String Choice3File,
    required String Choice3FileData,
    required String Choice4,
    required String Choice4File,
    required String Choice4FileData,
    required String CorrectAnswer,
    required String Hints,
  }) async {
    EasyLoading.show();
    var data = {
      "type": type.name,
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "QuestionID": QuestionID,
      "ExamID": ExamID,
      "ClassID": ClassID,
      "SubjectID": SubjectID,
      "QuestionType": "Obj",
      "Question": Question,
      "QuestionFile": QuestionFile,
      "QuestionFileData": QuestionFileData,
      "Choice1": Choice1,
      "Choice1File": Choice1File,
      "Choice1FileData": Choice1FileData,
      "Choice2": Choice2,
      "Choice2File": Choice2File,
      "Choice2FileData": Choice2FileData,
      "Choice3": Choice3,
      "Choice3File": Choice3File,
      "Choice3FileData": Choice3FileData,
      "Choice4": Choice4,
      "Choice4File": Choice4File,
      "Choice4FileData": Choice4FileData,
      "CorrectAnswer": CorrectAnswer,
      "Hints": Hints
    };
    Get.log("Mcq req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdatePaper,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Mcq req : ${data.toString()}");
      Get.log("Mcq res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<PaperModel> getDesQuestion({
    required String examId,
    required String clsId,
    required String subId,
  }) async {
    // EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": "GetAllDescriptiveQuestions",
      "ExamID": examId,
      "ClassID": clsId,
      "SubjectID": subId
    };
    try {
      final response = await Dio().post(
        EndPoints.QuestionList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Exam Des List req : ${data.toString()}");
      Get.log("Exam Des List Get : $response");
      // EasyLoading.dismiss();

      if (response.data["status"]) {
        return desPaperModel.value = PaperModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      // EasyLoading.dismiss();
      return e.response!.data;
    }
    return PaperModel();
  }

  Future<bool> saveDes({
    String QuestionID = "0",
    required String ExamID,
    required ExamType type,
    required String ClassID,
    required String SubjectID,
    required String Question,
    required String QuestionFile,
    required String QuestionFileData,
    required String CorrectAnswer,
    required String Hints,
  }) async {
    EasyLoading.show();
    var data = {
      "type": type.name,
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "QuestionID": QuestionID,
      "ExamID": ExamID,
      "ClassID": ClassID,
      "SubjectID": SubjectID,
      "QuestionType": "Des",
      "Question": Question,
      "QuestionFile": QuestionFile,
      "QuestionFileData": QuestionFileData,
      "CorrectAnswer": CorrectAnswer,
      "Hints": Hints
    };
    Get.log("Mcq req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdatePaper,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Mcq req : ${data.toString()}");
      Get.log("Mcq res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }

  Future<bool> deletePaper({
    required String questionId,
  }) async {
    EasyLoading.show();
    var data = {
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "EmpID": CommonService.employeeId,
      "type": "DeleteDescriptiveQuestionApp",
      "QuestionID": questionId,
    };
    Get.log("Mcq req : ${data.toString()}");

    try {
      final response = await Dio().post(
        EndPoints.UpdateExam,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Mcq req : ${data.toString()}");
      Get.log("Mcq res : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Get.log("${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }
}

enum ExamType {
  SelectExamPastApp,
  SelectExamUpcomingApp,
  InsertExam,
  UpdateExamApp,
  GetExamClassByID,
  SaveExamClassSubjectMappingApp,
  UpdateExamClassSubjectMappingApp,
  SaveobjectiveQuestionApp,
  UpdateobjectiveQuestionApp,
  DeleteDescriptiveQuestionApp,
  SaveDescriptiveQuestionApp,
  UpdateDescriptiveQuestionApp
}
