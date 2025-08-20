import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'model/employee_model.dart';
import '../util/end_points.dart';
import 'common_service.dart';

class EmployeeController extends GetxController{

  var employeeModel=EmployeeModel(records: []).obs;


  EmployeeController(){
   getEmployeesList();
  }

  Future<EmployeeModel> getEmployeesList() async {
    EasyLoading.show();
    var data={
      "school_code": CommonService.schoolCode,
      "SessionID": CommonService.currentSessionId,
      "BranchID": CommonService.branchId,
      "Type":"GetAllEmployee_Active"
    };
    try {
      final response = await Dio().post(
        EndPoints.EmpList,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: EndPoints.auth},
        ),
        data: data,
      );
      Get.log("Employees req  : ${data.toString()}");
      Get.log("Employees res  : $response");
      EasyLoading.dismiss();

      if (response.data["status"]) {
        return employeeModel.value =
            EmployeeModel.fromJson(response.data);
      } else {
        // Ams.ft("${response.data["message"]}");
      }
      return response.data;
    } on DioException catch (e) {
      Get.log("Employee res : ${e.response}");
      EasyLoading.dismiss();
      return e.response!.data;
    }
  }




  var isSelectAllEmployee = false.obs;

  var selectedEmployeeList = List<EmployeeRecord>.empty(growable: true).obs;
  // var initailCls = List<EmployeeRecord>.empty(growable: true).obs;

  var empIds = "".obs;

  //on all installment toggle switch
  void onEmployeeListSwitchChange(){
    if(isSelectAllEmployee.value) {
      selectedEmployeeList.value = List.of(employeeModel.value.records!,growable: true);
      empIds.value = selectedEmployeeList.map((e) => e.emp_ID).join(",");
      selectedEmployeeList.refresh();
      log("selected: "+selectedEmployeeList.toString());
    }else{
      selectedEmployeeList.value=[];
      empIds.value="";
    }
    selectedEmployeeList.refresh(); // Trigger UI refresh
    Get.log("Selected Employee: ${selectedEmployeeList.length}");
  }

  onConfirm(List<EmployeeRecord> list) {
    selectedEmployeeList.value = list;
    empIds.value = selectedEmployeeList.map((e) => e.emp_ID).toList().join(",");
    isSelectAllEmployee.value = list.length == employeeModel.value.records!.length;
    selectedEmployeeList.refresh();
  }
}