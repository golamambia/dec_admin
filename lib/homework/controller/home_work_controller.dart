import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/homework/service/home_work_type.dart';
import 'package:decora_admin/homework/view/homework_by_class_List.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/common_service.dart';
import '../../common/controller/cls_controller.dart';
import '../../util/file_utils.dart';
import '../service/home_work_service.dart';
import '../view/homework_class_list.dart';

class HomeWorkController extends GetxController {
  var homeworkService = Get.put(HomeWorkService());
  var homeworkType = HomeWorkType.GetAllHomework.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  late HomeWorkRecord currentHomeWork;

  var homeworkModel = HomeWorkModel().obs;
  var homeWorkByClassModel = HomeWorkModel().obs;
  var homeWorkClassList = HomeWorkModel().obs;

  TextEditingController title = TextEditingController(text: "");
  TextEditingController details = TextEditingController(text: "");
  TextEditingController chooseFile = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: Ams.getTodayDate());
  FileData? pickedFile;

  var homeWorkId = "0";

  var clsController = ClsController();

  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;

  // var classIds = "".obs;

  @override
  void onInit() async {
    _fakeData();
    homeworkModel.value = await fetchData();
    clsController.isSelectAllCls.value = false;
    super.onInit();
  }

  fetchData() async {
    homeworkModel.value = HomeWorkModel();
    return homeworkModel.value =
        await homeworkService.postGetHomeWorkList(type: homeworkType.value);
  }

  _fakeData() {
    var r = HomeWorkRecord(
        postMode: "asdfsfdsffds",
        // : "21-2-2024",
        postData: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        homeworkID: "2");
    homeworkModel.value = HomeWorkModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onSave() async {
    if (formKey.currentState!.validate()) {
      var result = await homeworkService.postSaveHomeWork(
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
//       required HomeWorkRecord homeworkRecord}) async {
//   var result = await homeworkService.postSaveHomework(
//       type: HomeWorkType.SaveHomework,
//       homeworkId: homeworkRecord.homeworkID!,
//       title: homeworkRecord.postMode!,
//       details: homeworkRecord.postData!,
//       date: homeworkRecord.homeworkDate!,
//       clsController.classIds: homeworkRecord.classID!,
//       status: status,
//       fileData: pickedFile?.base64String ?? "");
//
//   if (result == true) {
//     fn();
//   }
// }

  void onUpdate() async {
    if (formKey.currentState!.validate()) {
      var result = await homeworkService.postUpdateHomeWork(
          homeWorkId: homeWorkId,
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

  void onDeleteItem({required String homeWorkId}) async {
    log("click Delete");
    var result =
        await homeworkService.postDeleteHomeWork(homeWorkId: homeWorkId);

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
    homeWorkId = "0";
  }

  setFormValue({required HomeWorkRecord homeworkRecord}) {
    title.text = homeworkRecord.postMode ?? "";
    details.text = homeworkRecord.postData ?? "";
    clsController.classIds.value = homeworkRecord.classID ?? "";
    // date.text = homeworkRecord.homeworkDate ?? "";
    date.text = homeworkRecord.uploadDate!;
    clsController.selectedClassList.value = CommonService.classRecordFromClsId(clsController.classIds.value);
    homeWorkId = homeworkRecord.homeworkID!;
  }

  void onHomeWorkClassClick(clsId) async {
    Get.to(() => HomeWorkByClassList());
    homeWorkByClassModel.value =
        await homeworkService.getHomeWorkByClassId(clsId: clsId,homeWorkId:currentHomeWork.homeworkID);
  }

  void onViewClick(HomeWorkRecord homeWorkRecord) async {
    currentHomeWork=homeWorkRecord;
    Get.to(() => HomeWorkClassList());
    homeWorkClassList.value = await homeworkService.getHomeWorkClassList(
        homeWorkId: homeWorkRecord.homeworkID!);
  }
}
