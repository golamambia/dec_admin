import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/online_exam/service/exam_service.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/paper_model.dart';

class PaperController extends GetxController {
  ExamController examController = Get.find<ExamController>();
  var examService = Get.put(ExamService());
  var mdqPaperModel = PaperModel().obs;
  var desPaperModel = PaperModel().obs;

  //object
  var isActive1 = false.obs;
  var isActive2 = false.obs;
  var isActive3 = false.obs;
  var isActive4 = false.obs;

  String clsId = "";

  late var paperController = Get.put(PaperController());
  TextEditingController questionController = TextEditingController();
  TextEditingController choice1Controller = TextEditingController();
  TextEditingController choice2Controller = TextEditingController();
  TextEditingController choice3Controller = TextEditingController();
  TextEditingController choice4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();
  String questionFile = "";
  String answer1File = "";
  String answer2File = "";
  String answer3File = "";
  String answer4File = "";
  var questionFilePath = "".obs;
  var answer1FilePath = "".obs;
  var answer2FilePath = "".obs;
  var answer3FilePath = "".obs;
  var answer4FilePath = "".obs;
  String selected = "";
  final formKey = GlobalKey<FormState>();

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();

  PaperRecord? currentMcqRecord = null;
  PaperRecord? currentDesRecord = null;

  getCorrect() {
    switch (selected) {
      case "1":
        return choice1Controller.text;
      case "2":
        return choice2Controller.text;
      case "3":
        return choice3Controller.text;
      case "4":
        return choice4Controller.text;
    }
  }

  void fetchMcqPaper() async {
    mdqPaperModel.value = await examService.getMcqQuestion(
        examId: examController.examId.value,
        clsId: examController.clsId.value,
        subId: examController.subId.value);
  }

  void fetchDesPaper() async {
    desPaperModel.value = await examService.getDesQuestion(
        examId: examController.examId.value,
        clsId: examController.clsId.value,
        subId: examController.subId.value);
  }

  void onSaveMcq() async {
    if(getCorrect()==null) {
      Ams.ft("Must have one correct answer selected");
      return;
    }
    var status = await examService.saveMcq(
        QuestionID: examController.onlineSubMapId,
        type: ExamType.SaveobjectiveQuestionApp,
        ExamID: examController.examId.value,
        ClassID: examController.clsId.value,
        SubjectID: examController.subId.value,
        Question: questionController.text,
        QuestionFile: "",
        QuestionFileData: questionFile,
        Choice1: choice1Controller.text,
        Choice1File: "",
        Choice1FileData: answer1File,
        Choice2: choice2Controller.text,
        Choice2File: "",
        Choice2FileData: answer2File,
        Choice3: choice3Controller.text,
        Choice3File: "",
        Choice3FileData: answer3File,
        Choice4: choice4Controller.text,
        Choice4File: "",
        Choice4FileData: answer3File,
        CorrectAnswer: getCorrect(),
        Hints: "");

    if (status) {
      Get.back();
      fetchMcqPaper();
    }
  }

  void onUpdateMcq() async {
    if(getCorrect()==null) {
      Ams.ft("Must have one correct answer selected");
      return;
    }
    var status = await examService.saveMcq(
        QuestionID: examController.onlineSubMapId,
        type: ExamType.UpdateobjectiveQuestionApp,
        ExamID: examController.examId.value,
        ClassID: examController.clsId.value,
        SubjectID: examController.subId.value,
        Question: questionController.text,
        QuestionFile: "",
        QuestionFileData: questionFile,
        Choice1: choice1Controller.text,
        Choice1File: "",
        Choice1FileData: answer1File,
        Choice2: choice2Controller.text,
        Choice2File: "",
        Choice2FileData: answer2File,
        Choice3: choice3Controller.text,
        Choice3File: "",
        Choice3FileData: answer3File,
        Choice4: choice4Controller.text,
        Choice4File: "",
        Choice4FileData: answer3File,
        CorrectAnswer: getCorrect(),
        Hints: "");

    if (status) {
      Get.back();
      fetchMcqPaper();
    }
  }

  void onDeleteMcqAndDes({required String questionId}) async {
    var bool = await examService.deletePaper(questionId: questionId);
    if (bool) {
      fetchMcqPaper();
      fetchDesPaper();
    }
  }

  setFormMcq() {
    String isA = currentMcqRecord?.correctAnswer ?? "";
    examController.onlineSubMapId = currentMcqRecord?.questionID ?? "";
    if (isA == choice1Controller.text) {
      isActive1.value = true;
      selected = "1";
    } else if (isA == choice2Controller.text) {
      isActive2.value = true;
      selected = "2";
    } else if (isA == choice3Controller.text) {
      isActive3.value = true;
      selected = "3";
    } else if (isA == choice4Controller.text) {
      isActive4.value = true;
      selected = "4";
    }
    questionController.text = currentMcqRecord?.question ?? "";
    choice1Controller.text = currentMcqRecord?.choice1 ?? "";
    choice2Controller.text = currentMcqRecord?.choice2 ?? "";
    choice3Controller.text = currentMcqRecord?.choice3 ?? "";
    choice4Controller.text = currentMcqRecord?.choice4 ?? "";

    questionFile = currentMcqRecord?.questionFileData ?? "";

    // questionFile = qRecords.questionFileData??" == "null"
    //     ? ""
    //     : qRecords.questionFileData??";
    answer1File = currentMcqRecord?.choice1FileData ?? "";
    answer2File = currentMcqRecord?.choice2FileData ?? "";
    answer3File = currentMcqRecord?.choice3FileData ?? "";
    answer4File = currentMcqRecord?.choice4FileData ?? "";
  }

  setFormDes() {
    answerController.text = currentDesRecord?.correctAnswer ?? "";
    examController.onlineSubMapId = currentDesRecord?.questionID ?? "";

    questionController.text = currentDesRecord?.question ?? "";

    questionFile = currentDesRecord?.questionFile ?? "";
    questionFilePath.value = currentDesRecord?.questionFile ?? "";
  }

  reSetFormDes() {
    currentDesRecord = null;
    answerController.text = currentDesRecord?.correctAnswer ?? "";
    examController.onlineSubMapId = currentDesRecord?.questionID ?? "";
    questionController.text = currentDesRecord?.question ?? "";
    questionFile = currentDesRecord?.questionFile ?? "";
    questionFilePath.value = currentDesRecord?.questionFile ?? "";


  }

  reSetFormMcq() {
    currentMcqRecord = null;
    isActive1.value = false;
    isActive2.value = false;
    isActive3.value = false;
    isActive4.value = false;
    selected = "";
    questionController.text = currentMcqRecord?.question ?? "";
    choice1Controller.text = currentMcqRecord?.choice1 ?? "";
    choice2Controller.text = currentMcqRecord?.choice2 ?? "";
    choice3Controller.text = currentMcqRecord?.choice3 ?? "";
    choice4Controller.text = currentMcqRecord?.choice4 ?? "";

    questionFile = currentMcqRecord?.questionFileData ?? "";


    answer1File = currentMcqRecord?.choice1FileData ?? "";
    answer2File = currentMcqRecord?.choice2FileData ?? "";
    answer3File = currentMcqRecord?.choice3FileData ?? "";
    answer4File = currentMcqRecord?.choice4FileData ?? "";
  }

  void onSaveDes() async {
    var status = await examService.saveDes(
        QuestionID: examController.onlineSubMapId,
        type: ExamType.SaveDescriptiveQuestionApp,
        ExamID: examController.examId.value,
        ClassID: examController.clsId.value,
        SubjectID: examController.subId.value,
        Question: questionController.text,
        QuestionFile: "",
        QuestionFileData: questionFile,
        CorrectAnswer: answerController.text,
        Hints: "");

    if (status) {
      Get.back();
      fetchMcqPaper();
    }
  }

  void onUpdateDes() async {
    var status = await examService.saveDes(
        QuestionID: examController.onlineSubMapId,
        type: ExamType.UpdateobjectiveQuestionApp,
        ExamID: examController.examId.value,
        ClassID: examController.clsId.value,
        SubjectID: examController.subId.value,
        Question: questionController.text,
        QuestionFile: "",
        QuestionFileData: questionFile,
        CorrectAnswer: answerController.text,
        Hints: "");

    if (status) {
      Get.back();
      fetchDesPaper();
    }
  }
}
