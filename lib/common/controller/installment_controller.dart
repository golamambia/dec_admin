import 'dart:developer';

import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/service/fee_service.dart';
import 'package:get/get.dart';


class InstallmentController extends GetxController{

  var feeService =Get.put(FeeService());
  var installmentModel=InstallmentModel(records: []).obs;


  @override
  void onInit() async{
    feeService.getInstallmentList();
    super.onInit();
  }

  var isSelectAllInstallment = false.obs;

  var selectedInstallmentList = List<InstallmentRecord>.empty(growable: true).obs;
  // var initailCls = List<InstallmentRecord>.empty(growable: true).obs;

  var installmentIds = "".obs;

  //on all installment toggle switch
  void onInstallmentListSwitchChange(){
    if(isSelectAllInstallment.value) {
      selectedInstallmentList.value = List.of(FeeService.installmentModel.value.records,growable: true);
      installmentIds.value = selectedInstallmentList.map((e) => e.installmentID).join(",");
      selectedInstallmentList.refresh();
      log("selected: "+selectedInstallmentList.toString());
    }else{
      selectedInstallmentList.value=[];
      installmentIds.value="";
    }
    selectedInstallmentList.refresh(); // Trigger UI refresh
    Get.log("Selected Installment: ${selectedInstallmentList.length}");
  }

  onConfirm(List<InstallmentRecord> list) {
    selectedInstallmentList.value = list;
    installmentIds.value = selectedInstallmentList.map((e) => e.installmentID).toList().join(",");
    isSelectAllInstallment.value = list.length == FeeService.installmentModel.value.records!.length;
    selectedInstallmentList.refresh();
  }
}