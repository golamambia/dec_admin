import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/common_service.dart';
import '../../common/controller/cls_controller.dart';
import '../../util/file_utils.dart';
import '../model/online_cls_model.dart';
import '../service/online_cls_service.dart';
import '../service/online_cls_type.dart';

class OnlineClsController extends GetxController {
  var onlineClsService = Get.put(OnlineClsService());
  var onlineClsType = OnlineClsType.GetAllUpcommingOnlineClass.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  var onlineClsModel = OnlineClsModel().obs;
  TextEditingController title = TextEditingController(text: "");
  TextEditingController link = TextEditingController(text: "");
  TextEditingController time = TextEditingController(text: "");

  // TextEditingController details = TextEditingController(text: "");
  TextEditingController chooseFile = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: Ams.getTodayDate());
  FileData? pickedFile;

  var onlineClsId = "0";

  var clsController = ClsController();

  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;

  // var classIds = "".obs;

  @override
  void onInit() async {
    _fakeData();
    onlineClsModel.value = await fetchData();
    clsController.isSelectAllCls.value = false;
    super.onInit();
  }

  fetchData() async {
    onlineClsModel.value = OnlineClsModel();
    return onlineClsModel.value =
        await onlineClsService.postGetOnlineClsList(type: onlineClsType.value);
  }

  _fakeData() {
    var r = OnlineClsRecord(
        title: "asdfsfdsffds",
        // : "21-2-2024",
        // className: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        onlineClassID: "2");
    onlineClsModel.value = OnlineClsModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onSave() async {
    if (formKey.currentState!.validate()) {
      var result = await onlineClsService.postSaveOnlineCls(
          title: title.text,
          // details: details.text,
          date: date.text,
          clsIds: clsController.classIds.value,
          status: isLive.value,
          link: link.text,
          time: time.text);

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
//       required OnlineClsRecord onlineClsRecord}) async {
//   var result = await onlineClsService.postSaveHomework(
//       type: OnlineClsType.SaveHomework,
//       onlineClsId: onlineClsRecord.onlineClsID!,
//       title: onlineClsRecord.postMode!,
// //       details: onlineClsRecord.postData!,
//       date: onlineClsRecord.onlineClsDate!,
//       clsController.classIds: onlineClsRecord.classID!,
//       status: status,
//       fileData: pickedFile?.base64String ?? "");
//
//   if (result == true) {
//     fn();
//   }
// }

  void onUpdate() async {
    if (formKey.currentState!.validate()) {
      var result = await onlineClsService.postUpdateOnlineCls(
          OnlineClassID: onlineClsId,
          title: title.text,
          date: date.text,
          status: isLive.value,
          clsIds: clsController.classIds.value,
          time: time.text,
          link: link.text);

      if (result == true) {
        reset();
        Get.back();
        fetchData();
      }
    }
  }

  void onCardSwitchToggle(
      {required bool status, required OnlineClsRecord onlineClsRecord}) async {
    if (formKey.currentState!.validate()) {
      var result = await onlineClsService.postUpdateOnlineCls(
          OnlineClassID: onlineClsRecord.onlineClassID!,
          title: onlineClsRecord.title!,
          date: onlineClsRecord.classDate!,
          status: status,
          clsIds: onlineClsRecord.classID!,
          time: onlineClsRecord.classTime!,
          link: onlineClsRecord.classLink!);

      if (result == true) {
        reset();
        Get.back();
        fetchData();
      }
    }
  }

  void onDeleteItem({required String onlineClsId}) async {
    log("click Delete");
    var result =
        await onlineClsService.postDeleteOnlineCls(onlineClsId: onlineClsId);

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
    link.text = "";
    time.text = "";
    // details.text="";
    date.text = "";
    isLive.value = true;
    onlineClsId = "0";
  }

  setFormValue({required OnlineClsRecord onlineClsRecord}) {
    title.text = onlineClsRecord.title ?? "";
    // details.text = onlineClsRecord. ?? "";
    clsController.classIds.value = onlineClsRecord.classID ?? "";
    // date.text = onlineClsRecord.onlineClsDate ?? "";
    link.text = onlineClsRecord.classLink ?? "";
    time.text = onlineClsRecord.classTime ?? "";
    date.text = onlineClsRecord.classDate ?? "";
    clsController.selectedClassList.value = CommonService.classRecordFromClsId(clsController.classIds.value);

    onlineClsId = onlineClsRecord.onlineClassID!;
  }
}
