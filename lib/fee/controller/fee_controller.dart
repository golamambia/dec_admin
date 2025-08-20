
import 'package:decora_admin/fee/model/fee_model.dart';
import 'package:decora_admin/fee/model/student_search_model.dart';
import 'package:decora_admin/fee/service/fee_service.dart';
import 'package:decora_admin/fee/service/fee_type.dart';
import 'package:decora_admin/fee/view/fee_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/controller/cls_controller.dart';
import '../../common/controller/installment_controller.dart';

class FeeController extends GetxController {
  var feeModel = FeeModel().obs;
  var feeService = Get.put(FeeService());
  var clsController = ClsController();
  var installmentController = InstallmentController();
  var formKey = GlobalKey<FormState>();

  // var installIds = TextEditingController();
  var stdId = "0";
  var searchItem = TextEditingController();
  var date = TextEditingController();

  //0->Student Wise||1->Class Wise
  var radioIndex = 0.obs;
  var studentModel = StudentSearchModel().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   searchItem.addListener(() => _print,);
  // }
  //
  //
  // @override
  // void dispose() {
  //   searchItem.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void onClose() {
  //   searchItem.dispose();
  //   super.onClose();
  // }

  Future<List<StudentSearchRecord>?> fetchStudentDetails() async {
    // var r1=StudentRecord(value: "ram test1");
    // var r2=StudentRecord(value: "ram test1");
    // StudentModel()
    if (searchItem.text.length < 2) return null;
    studentModel.value =
        await feeService.getStudentSearchList(searchItem: searchItem.text);
    studentModel.value.records?.forEach(
        (element) => Get.log("fetchStudentDetails :${element.toJson()}"));
    return studentModel.value.records;
  }

  String? emptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  getDetails() async {
    feeModel.value = await feeService.getFeeList(
        type: radioIndex == 0 ? FeeType.Student : FeeType.Class,
        installmentID: installmentController.installmentIds.value,
        currentDate: date.text,
        stdId: radioIndex == 0 ? stdId : "0",
        classIds: radioIndex == 1 ? clsController.classIds.value : "0");
    // if(feeModel.value.records!=null&&feeModel.value.records!.length>0){
    //   Get.to(()=> FeeList());
    // }
  }
}

// enum _RadioButton { StudentWiseRadio, ClassWiseRadio }
