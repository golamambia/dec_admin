import 'package:bottom_bar_matu/utils/app_utils.dart';

import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/common_service.dart';
import '../../common/controller/cls_controller.dart';
import '../../common/model/class_list.dart';
import '../../util/file_utils.dart';
import '../model/syllabus_model.dart';
import '../service/syllabus_service.dart';
import '../service/syllabus_type.dart';

class SyllabusController extends GetxController {

  var syllabusService = Get.put(SyllabusService());
  var syllabusType = SyllabusType.GetAllSyllabus.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  var syllabusModel = SyllabusModel().obs;
  TextEditingController title = TextEditingController(text: "");
  // TextEditingController details = TextEditingController(text: "");
  TextEditingController chooseFile = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: Ams.getTodayDate());
  FileData? pickedFile;

  var syllabusId="0";

  var clsController  = ClsController();

  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;

  // var classIds = "".obs;

  @override
  void onInit() async {
    _fakeData();
    syllabusModel.value =
    await fetchData();
    clsController.isSelectAllCls.value=false;
    super.onInit();
  }

  fetchData() async {
    syllabusModel.value =SyllabusModel();
    return syllabusModel.value =
    await syllabusService.postGetSyllabusList(type: syllabusType.value);
  }

  _fakeData() {
    var r = SyllabusRecord(
        title: "asdfsfdsffds",
        // : "21-2-2024",
        // className: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        syllabusID: "2");
    syllabusModel.value = SyllabusModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }


  void onSave() async {
  if (formKey.currentState!.validate()) {
    var result = await syllabusService.postSaveSyllabus(
        title: title.text,
        // details: details.text,
        uploadDate: date.text,
        clsIds: clsController.classIds.value,
        // status: isLive.value,
        fData: pickedFile?.base64String ?? "",
        fType: pickedFile?.fileExt??""
    );
    
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
//       required SyllabusRecord syllabusRecord}) async {
//   var result = await syllabusService.postSaveHomework(
//       type: SyllabusType.SaveHomework,
//       syllabusId: syllabusRecord.syllabusID!,
//       title: syllabusRecord.postMode!,
// //       details: syllabusRecord.postData!,
//       date: syllabusRecord.syllabusDate!,
//       clsController.classIds: syllabusRecord.classID!,
//       status: status,
//       fileData: pickedFile?.base64String ?? "");
//
//   if (result == true) {
//     fn();
//   }
// }

void onUpdate() async {
  if (formKey.currentState!.validate()) {
    var result = await syllabusService.postUpdateSyllabus(
        syllabusId: syllabusId,
        title: title.text,
        // details: details.text,
        uploadDate: date.text,
        clsIds: clsController.classIds.value,
        // status: isLive.value,
        fType: pickedFile?.fileExt??"",
        fData: pickedFile?.base64String ?? ""
    );

    if (result == true) {
      reset();
      Get.back();
      fetchData();
    }
  }
}

void onDeleteItem({ required String syllabusId}) async {
    log("click Delete");
  var result = await syllabusService.postDeleteSyllabus(
      syllabusId: syllabusId);

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
    title.text="";
    // details.text="";
    date.text="";
    isLive.value=true;
    syllabusId="0";
  }

  setFormValue({required SyllabusRecord syllabusRecord}) {
    title.text = syllabusRecord.title ?? "";
    // details.text = syllabusRecord. ?? "";
    clsController.classIds.value = syllabusRecord.classID ?? "";
    // date.text = syllabusRecord.syllabusDate ?? "";
    date.text = syllabusRecord.uploadDate!;
    clsController.selectedClassList.value =CommonService.classRecordFromClsId(clsController.classIds.value);
    syllabusId=syllabusRecord.syllabusID!;

  }
}