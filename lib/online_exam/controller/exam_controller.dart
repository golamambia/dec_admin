import 'package:decora_admin/mark/service/mark_service.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_service.dart';
import '../../common/controller/cls_controller.dart';
import '../../mark/model/mark_info_model.dart';
import '../service/exam_service.dart';

class ExamController extends GetxController {
  var examModel = ExamModel().obs;
  var examService = Get.put(ExamService());
  var formKey = GlobalKey<FormState>();
  var clsController = ClsController();
  var examClsList = ExamModel().obs;
  var examSubList = ExamModel().obs;

  var subjectInfoModel = MarkInfoModel().obs;

  TextEditingController examName = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  var isResult = true.obs;
  var markService = Get.put(MarkService());
  var subId = "".obs;

  ExamType currentExamType = ExamType.SelectExamUpcomingApp;

  var examId = "".obs;
  var clsId = "".obs;
  String onlineSubMapId = "";
  var currentSubId = "";

  // var currentSubId = "".obs;
  ExamRecords? updateExamRecords = null;

  TextEditingController examDate = TextEditingController();
  TextEditingController timeIn = TextEditingController();
  TextEditingController timeOut = TextEditingController();
  TextEditingController objCount = TextEditingController();
  TextEditingController objMark = TextEditingController();
  TextEditingController desCount = TextEditingController();
  TextEditingController desMark = TextEditingController();
  TextEditingController passMark = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  void fetchExam() async {
    examModel.value = await examService.getExamList(type: currentExamType);
  }

  void fetchExamClsList() async {
    examClsList.value = ExamModel();
    Get.log("Exam id: ${examId.value}");
    examClsList.value =
        await examService.getExamClassList(examId: examId.value);
  }

  void fetchSubList() async {
    Get.log("cls id: ${clsId.value}");

    subjectInfoModel.value = await markService.subjectList(clsId: clsId.value);
  }

  void fetchExamSubList() async {
    examSubList.value = await examService.getExamSubList(
        examId: examId.value, clsId: clsId.value, subId: subId.value);
  }

  void subCallBack(String? val) async {
    Get.log(val ?? "");
    Get.log(subId.value ?? "");
    examSubList.value = await examService.getExamSubList(
        examId: examId.value, clsId: clsId.value, subId: val ?? "");
  }

  void resetExamForm() {
    examName.text = "";
    fromDate.text = "";
    toDate.text = "";
    examId.value = "";
    clsId.value = "";
    currentSubId = "";
    isResult.value = true;
    clsController.classIds.value = "";
    clsController.selectedClassList.value = [];
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onExamDeleteItem({required homeWorkId}) {}

  void onSaveExam() async {
    var status = await examService.saveExam(
        type: ExamType.InsertExam,
        examName: examName.text,
        fromDate: fromDate.text,
        toDate: toDate.text,
        isResult: isResult.value == true ? "1" : "0",
        clsIds: clsController.classIds.value);
    if (status) {
      Get.back();
      fetchExam();
    } else {
      Ams.ft("Not saving please try later!!!");
    }
  }

  void onUpdate() async {
    var status = await examService.saveExam(
        examId: examId.value,
        type: ExamType.UpdateExamApp,
        examName: examName.text,
        fromDate: fromDate.text,
        toDate: toDate.text,
        isResult: isResult.value == true ? "1" : "0",
        clsIds: clsController.classIds.value);
    if (status) {
      Get.back();
      fetchExam();
    } else {
      Ams.ft("Not saving please try later!!!");
    }
  }

  void setExamForm(ExamRecords examRecord) {
    updateExamRecords = examRecord;
    examId.value = examRecord.examID ?? "";
    Get.log("Class : ${updateExamRecords?.classID ?? " "}");
    examName.text = updateExamRecords?.exam ?? "";
    fromDate.text = updateExamRecords?.examDateFrom ?? "";
    toDate.text = updateExamRecords?.examDateTo ?? "";
    examId.value = updateExamRecords?.examID ?? "";
    ;
    clsController.classIds.value = updateExamRecords?.classID ?? "";
    clsController.selectedClassList.value =
        CommonService.classRecordFromClsId(clsController.classIds.value);
    isResult.value = updateExamRecords?.isResult == "True" ? true : false;
  }

  void setSubjectForm(ExamRecords examRecord) {
    currentSubId = examRecord.subjectID ?? "";
    onlineSubMapId = examRecord.onlineExamClassSubjectMappID ?? "";
    examDate.text = examRecord.examDate ?? "";
    timeIn.text = examRecord.timeIn ?? "";
    timeOut.text = examRecord.timeOut ?? "";
    objCount.text = examRecord.objQuesNo ?? "";
    objMark.text = examRecord.objQuesMarks ?? "";
    desCount.text = examRecord.desQuesNo ?? "";
    desMark.text = examRecord.desQuesMarks ?? "";
    passMark.text = examRecord.passMarks ?? "";
  }

  void resetSubjectForm() {
    onlineSubMapId="";
    currentSubId = "";
    timeIn.text = "";
    examDate.text = "";
    timeOut.text = "";
    objCount.text = "";
    objMark.text = "";
    desCount.text = "";
    desMark.text = "";
    passMark.text = "";
  }

  void onSaveExamSubject() async {
    Get.log(examId.value);
    Get.log(clsId.value);

    var status = await examService.saveExamSubject(
        type: ExamType.SaveExamClassSubjectMappingApp,
        examId: examId.value,
        subId: subId.value,
        clsId: clsId.value,
        examDate: examDate.text,
        objCount: objCount.text,
        objMarks: objMark.text,
        desCount: desCount.text,
        desMarks: desMark.text,
        timeIn: timeIn.text,
        timeOut: timeOut.text,
        passMark: passMark.text);
    if (status) {
      Get.back();
      fetchExamSubList();
    } else {
      Ams.ft("Not saving please try later!!!");
    }
  }

  void onUpdateExamSubject() async {
    var status = await examService.saveExamSubject(
        type: ExamType.UpdateExamClassSubjectMappingApp,
        onlineSubId: onlineSubMapId,
        examId: examId.value,
        subId: subId.value,
        clsId: clsId.value,
        examDate: examDate.text,
        objCount: objCount.text,
        objMarks: objMark.text,
        desCount: desCount.text,
        desMarks: desMark.text,
        timeIn: timeIn.text,
        timeOut: timeOut.text,
        passMark: passMark.text);
    if (status) {
      Get.back();
      fetchExamSubList();
    } else {
      Ams.ft("Not saving please try later!!!");
    }
  }
}
