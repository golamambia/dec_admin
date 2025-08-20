import 'dart:ffi';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/notice/model/notice_model.dart';
import 'package:decora_admin/notice/service/notice_service.dart';
import 'package:decora_admin/notice/service/notice_type.dart';
import 'package:decora_admin/util/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/controller/cls_controller.dart';
import '../../common/model/class_list.dart';

class NoticeController extends GetxController {
  var noticeService = Get.put(NoticeService());
  var noticeType = NoticeType.GetAllNoticeUpcoming.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  var noticeModel = NoticeModel().obs;
  TextEditingController title = TextEditingController(text: "");
  TextEditingController details = TextEditingController(text: "");
  TextEditingController chooseFile = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: "");
  FileData? pickedFile;

  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;



  var clsController=ClsController();

  @override
  void onInit() async {
    _fakeData();
    noticeModel.value =
        await fetchData();
    super.onInit();
  }

  fetchData() async {
    noticeModel.value=NoticeModel();
     noticeModel.value =
        await noticeService.postGetNoticeList(type: noticeType.value);
  }

  _fakeData() {
    var r = NoticeRecord(
        type: "asdfsfdsffds",
        noticeDate: "21-2-2024",
        noticeDetails: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        noticeID: "2");
    noticeModel.value = NoticeModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onSave() async {
    if (formKey.currentState!.validate()) {
      var result = await noticeService.postSaveNotice(
          type: NoticeType.SaveNotice,
          noticeId: "0",
          title: title.text,
          details: details.text,
          date: date.text,
          classIds: clsController.classIds.value,
          status: isLive.value,
          fileType: pickedFile?.fileExt??"",
          fileData: pickedFile?.base64String ?? "");

      if (result == true) {
        Get.back();
        reset();
        fetchData();
      }
    }
  }

  void onCardSwitchToggle(
      {
      required bool status,
      required NoticeRecord noticeRecord}) async {
    var result = await noticeService.postSaveNotice(
        type: NoticeType.UpdateNoticeApp,
        noticeId: noticeRecord.noticeID!,
        title: noticeRecord.noticeTitle!,
        details: noticeRecord.noticeDetails!,
        date: noticeRecord.noticeDate!,
        classIds: noticeRecord.classID!,
        status: status,
        fileType: pickedFile?.fileExt??"",
        fileData: pickedFile?.base64String ?? "");

    if (result == true) {
      fetchData();
    }
  }

  void onUpdate({required Function fn, required String noticeId}) async {
    if (formKey.currentState!.validate()) {
      var result = await noticeService.postSaveNotice(
          type: NoticeType.UpdateNoticeApp,
          noticeId: noticeId,
          title: title.text,
          details: details.text,
          date: date.text,
          classIds: clsController.classIds.value,
          status: isLive.value,
          fileType: pickedFile?.fileExt??"",
          fileData: pickedFile?.base64String ?? "");

      if (result == true) {
        reset();
        Get.back();
        fn();
      }
    }
  }

  void onDeleteItem({required String noticeId, required Function fn}) async {
    var result = await noticeService.postSaveNotice(
        type: NoticeType.DeleteNotice,
        noticeId: noticeId,
        title: title.text,
        details: details.text,
        date: date.text,
        classIds: clsController.classIds.value,
        status: isLive.value,
        fileType: pickedFile?.fileExt??"",
        fileData: pickedFile?.base64String ?? "");

    if (result == true) {
      Future.delayed(Duration(seconds: 1));
      fn();
    }
  }

  onConfirm(List<ClassRecord> list) {
    clsController.selectedClassList.value = list;
    clsController.classIds.value = clsController.selectedClassList.map((e) => e.classID).toList().join(",");
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
    title.text="";
    details.text="";
    dayType.value = "";
  }

  setFormValue({required NoticeRecord noticeRecord}) {
    title.text = noticeRecord.noticeTitle ?? "";
    details.text = noticeRecord.noticeDetails ?? "";
    clsController.classIds.value = noticeRecord.classID ?? "";
    date.text = noticeRecord.noticeDate ?? "";
    clsController.selectedClassList.value = CommonService.classRecordFromClsId(clsController.classIds.value);

  }
}
