import 'package:decora_admin/activity/model/activity_model.dart';
import 'package:decora_admin/activity/service/activity_service.dart';
import 'package:decora_admin/activity/service/activity_type.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/common/model/class_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/controller/cls_controller.dart';

class ActivityController extends GetxController {
  var activityService = Get.put(ActivityService());
  var activityType = ActivityType.GetAllActivityUpcoming.obs;
  var refreshState = 0.obs;
  var formKey = GlobalKey<FormState>();

  var activityModel = ActivityModel().obs;
  TextEditingController title = TextEditingController(text: "");
  TextEditingController details = TextEditingController(text: "");
  TextEditingController date = TextEditingController(text: "");
  final days = ["Holiday", "Working Day"];
  int count = 0;
  var dayType = "".obs;

  var isLive = true.obs;

  ClsController clsController = ClsController();

  @override
  void onInit() async {
    _fakeData();
    activityModel.value =
        await fetchData(activityType: ActivityType.GetAllActivityUpcoming);
    super.onInit();
  }

  fetchData({required ActivityType activityType}) async {
    return activityModel.value =
        await activityService.postGetActivityList(type: activityType) ??
            ActivityModel();
  }

  _fakeData() {
    var r = ActivityRecord(
        type: "asdfsfdsffds",
        activityDate: "21-2-2024",
        activityDetails: "Dfdsfdsfsf sf sa sa ds s f dsf sf sf ",
        activityID: "2");
    activityModel.value = ActivityModel(records: [r, r, r, r, r]);
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  void onSave({required Function fn}) async {
    if (formKey.currentState!.validate()) {
      var result = await activityService.postSaveActivity(
          type: ActivityType.SaveActivity,
          activityId: "0",
          title: title.text,
          details: details.text,
          date: date.text,
          classIds: clsController.classIds.value,
          status: isLive.value);

      if (result == true) {
        Get.back();
        reset();
        fn();
      }
    }
  }

  void onCardSwitchToggle(
      {required Function fn,
      required bool status,
      required ActivityRecord activityRecord}) async {
    var result = await activityService.postSaveActivity(
        type: ActivityType.SaveActivity,
        activityId: activityRecord.activityID!,
        title: activityRecord.activityTitle!,
        details: activityRecord.activityDetails!,
        date: activityRecord.activityDate!,
        classIds: activityRecord.classID!,
        status: status);

    if (result == true) {
      fn();
    }
  }

  void onUpdate({required Function fn, required String activityId}) async {
    if (formKey.currentState!.validate()) {
      var result = await activityService.postSaveActivity(
          type: ActivityType.SaveActivity,
          activityId: activityId,
          title: title.text,
          details: details.text,
          date: date.text,
          classIds: clsController.classIds.value,
          status: isLive.value);

      if (result == true) {
        reset();
        Get.back();
        fn();
      }
    }
  }

  void onDeleteItem({required String activityId, required Function fn}) async {
    var result = await activityService.postSaveActivity(
        type: ActivityType.DeleteActivity,
        activityId: activityId,
        title: title.text,
        details: details.text,
        date: date.text,
        classIds: clsController.classIds.value,
        status: isLive.value);

    if (result == true) {
      Future.delayed(Duration(seconds: 1));
      fn();
    }
  }

  onConfirm(List<ClassRecord> list) {
    clsController.selectedClassList.value = list;
    clsController.classIds.value = clsController.selectedClassList
        .map((e) => e.classID)
        .toList()
        .join(",");
  }

  reset() {
    formKey.currentState?.reset();
    clsController.selectedClassList.value = [];
    clsController.classIds.value = "";
    dayType.value = "";
  }

  setFormValue({required ActivityRecord activityRecord}) {
    title.text = activityRecord.activityTitle ?? "";
    details.text = activityRecord.activityDetails ?? "";
    clsController.classIds.value = activityRecord.classID ?? "";
    date.text = activityRecord.activityDate ?? "";
    clsController.selectedClassList.value = CommonService.classRecordFromClsId(clsController.classIds.value);

  }
}
