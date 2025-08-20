import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:decora_admin/assignmnent/view/assignment_by_class_List.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/common_service.dart';
import '../../common/controller/cls_controller.dart';
import '../../common/model/class_list.dart';
import '../../util/file_utils.dart';
import '../model/assignment_model.dart';
import '../service/assignment_service.dart';
import '../service/assignment_type.dart';
import '../view/assignment_class_list.dart';

class AssignmentController extends GetxController {
  var assignmentService = Get.put(AssignmentService());
  var assignmentType = AssignmentType.GetAllAssignment.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  var assignmentModel = AssignmentModel().obs;
  var assignmentClassList = AssignmentModel().obs;
  var assignmentByClassModel = AssignmentModel().obs;
  TextEditingController title = TextEditingController(text: "");
  TextEditingController details = TextEditingController(text: "");
  TextEditingController chooseFile = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: Ams.getTodayDate());
  FileData? pickedFile;

  var assignmentId = "0";

  var clsController = ClsController();

  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;

  // var classIds = "".obs;

  late AssignmentRecord currentAssigment;


  @override
  void onInit() async {
    _fakeData();
    assignmentModel.value = await fetchData();
    clsController.isSelectAllCls.value = false;
    super.onInit();
  }

  fetchData() async {
    assignmentModel.value = AssignmentModel();
    return assignmentModel.value = await assignmentService
        .postGetAssignmentList(type: assignmentType.value);
  }

  _fakeData() {
    var r = AssignmentRecord(
        title: "asdfsfdsffds",
        // : "21-2-2024",
        // postData: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        assignmentID: "2");
    assignmentModel.value = AssignmentModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onSave() async {
    if (formKey.currentState!.validate()) {
      var result = await assignmentService.postSaveAssignment(
          title: title.text,
          details: details.text,
          uploadDate: date.text,
          clsIds: clsController.classIds.value,
          // status: isLive.value,
          fData: pickedFile?.base64String ?? "",
          fType: pickedFile?.fileExt ?? "");

      log("save");

      if (result == true) {
        Get.back();
        reset();
        fetchData();
      }
    }
  }

// void onCardSwitchToggle(
//     {required Function fn,
//       required bool status,
//       required AssignmentRecord assignmentRecord}) async {
//   var result = await assignmentService.postSaveAssignment(
//       type: AssignmentType.SaveAssignment,
//       assignmentId: assignmentRecord.assignmentID!,
//       title: assignmentRecord.title!,
// //       details: assignmentRecord.postData!,
//       date: assignmentRecord.assignmentDate!,
//       clsController.classIds: assignmentRecord.classID!,
//       status: status,
//       fileData: pickedFile?.base64String ?? "");
//
//   if (result == true) {
//     fn();
//   }
// }

  void onUpdate() async {
    if (formKey.currentState!.validate()) {
      var result = await assignmentService.postUpdateAssignment(
          assignmentId: assignmentId,
          title: title.text,
          details: details.text,
          uploadDate: date.text,
          clsIds: clsController.classIds.value,
          // status: isLive.value,
          fType: pickedFile?.fileExt ?? "",
          fData: pickedFile?.base64String ?? "");

      if (result == true) {
        reset();
        Get.back();
        fetchData();
      }
    }
  }

  void onDeleteItem({required String assignmentId}) async {
    log("click Delete");
    var result =
        await assignmentService.postDeleteAssignment(assignmentId: assignmentId);

    if (result == true) {
      fetchData();
    }
  }

  onChooseFileTap() async {
    pickedFile = await FileUtils.pickFile();
    chooseFile.text = pickedFile?.fileName ?? "";
    Get.log("base64String: ${pickedFile?.base64String}");
  }

  reset() {
    formKey.currentState?.reset();
    clsController.selectedClassList.value = [];
    clsController.classIds.value = "";
    dayType.value = "";
    title.text = "";
    details.text = "";
    date.text = "";
    isLive.value = true;
    assignmentId = "0";
  }

  setFormValue({required AssignmentRecord assignmentRecord}) {
    title.text = assignmentRecord.title ?? "";
    // details.text = assignmentRecord.postData ?? "";
    clsController.classIds.value = assignmentRecord.classID ?? "";
    // date.text = assignmentRecord.assignmentDate ?? "";
    date.text = assignmentRecord.uploadDate!;
    clsController.selectedClassList.value =CommonService.classRecordFromClsId(clsController.classIds.value);

    assignmentId = assignmentRecord.assignmentID!;
  }
  void onViewClick(AssignmentRecord assignmentRecord) async{
     currentAssigment=assignmentRecord;
    Get.to(()=> AssignmentClassList());
    assignmentClassList.value= await assignmentService.getAssignmentClassList(assignmentId: assignmentRecord.assignmentID);
  }

  void onAssignmentClassClick(String clsId) async{
    Get.to(()=> AssignmentByClassList());
    assignmentByClassModel.value= await assignmentService.getAssignmentByClassId(clsId:clsId,assignmentId:currentAssigment.assignmentID!);
  }
}
