import 'package:decora_admin/mark/model/student_mark_model.dart';
import 'package:decora_admin/mark/service/mark_service.dart';
import 'package:decora_admin/mark/service/mark_type.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MarkController extends GetxController {
  var markService = Get.put(MarkService());

  //not using it in the list so building instead it using markService studentMarkModel in the ui
  // it might create confusion that's why i comment it
  var studentMarkModel = StudentMarkModel().obs;

  var formKey = GlobalKey<FormState>();

  var exam_max_mark = "";

  var clsId = "".obs;
  var subId = "".obs;
  var examId = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void clsCallBack(String? clsId) {
    // Get.log("Callback call : ${clsId}");
    subId.value = "";
    examId.value = "";
    markService.subjectList(clsId: clsId ?? "");
  }

  void subCallBack(String? val) {
    // Get.log("Callback call : ${clsId}");
    examId.value = "";
    markService.examList(clsId: clsId.value, subId: subId.value);
  }

  void examCallback(String? val) {
    // Get.log("Callback call : ${clsId}");
    var where = markService.examInfoModel.value.records?.where(
      (element) => element.examID == val,
    );
    exam_max_mark = where?.first.maxMarks ?? "";
    markService.examList(clsId: clsId.value, subId: subId.value);
  }

  Future<StudentMarkModel> getStudentList() async {
    Get.log("Calling student list");
    studentMarkModel.value = await markService.studentList(
        clsId: clsId.value, subId: subId.value, examId: examId.value);
    Get.log("Calling student list : ${studentMarkModel.value.toString()}");
    return studentMarkModel.value;
  }

  saveMark() async {
    // if (markService.studentMarkModel.value.footer?.first.isPersmission=="0") {
    //   Ams.ft("Access denied!! Please contact the administrator.");
    //   return;
    // }
    var bool = await markService.saveStudentMark(
        clsId: clsId.value,
        subId: subId.value,
        examId: examId.value,
        maxMark: exam_max_mark,
        objStudentMarkRecordeList: markService.studentMarkModel.value.school,
        saveType:
            markService.studentMarkModel.value.setting?.first.grade == "Main"
                ? MarkType.InsertMarks.name
                : MarkType.InsertGrade.name);
    if (bool) {
      Ams.ft("Marks saved");
      Get.back();
    }
  }
}
