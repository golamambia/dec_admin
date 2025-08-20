import 'dart:ui';

import 'package:get/get.dart';

import '../common_service.dart';
import '../model/class_list.dart';


class ClsController extends GetxController{

  Function(String)? callback;
  ClsController({ this.callback});

  var isSelectAllCls = false.obs;

  var selectedClassList = List<ClassRecord>.empty(growable: true).obs;
  // var initailCls = List<ClassRecord>.empty(growable: true).obs;

  var classIds = "".obs;

  void onSwitchClassListChange(){
    if(isSelectAllCls.value) {
      selectedClassList.value = List.of(CommonService.classList.value.records!,growable: true);
      classIds.value = selectedClassList.map((e) => e.classID).join(",");
      selectedClassList.refresh();
      Get.log("selected: "+selectedClassList.toString());
    }else{
      selectedClassList.value=[];
      classIds.value="";
    }
    selectedClassList.refresh(); // Trigger UI refresh
    Get.log("Selected classes: ${selectedClassList.length}");
    callback?.call(classIds.value);
  }

  onConfirm(List<ClassRecord> list) {
    selectedClassList.value = list;
    classIds.value = selectedClassList.map((e) => e.classID).toList().join(",");
    isSelectAllCls.value = list.length == CommonService.classList.value.records!.length;
    selectedClassList.refresh();
    callback?.call(classIds.value);
  }
}