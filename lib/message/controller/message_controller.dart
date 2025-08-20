import 'package:decora_admin/common/controller/student_controller.dart';
import 'package:decora_admin/common/employee_controller.dart';
import 'package:decora_admin/message/service/message_service.dart';
import 'package:decora_admin/message/service/message_type.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/objectDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/controller/cls_controller.dart';

class MessageController extends GetxController {
  var studentController = StudentController();
  var employeeController = EmployeeController();
  var clsController = ClsController();
  var messageService = Get.put(MessageService());

  //0->Class Wise||1->Student Wise||2->TeacherWise

  var radioIndex = 0.obs;
  var messageCharCount = 0.obs;
  String templateId = "";

  var message = TextEditingController().obs;

  @override
  void onInit() {
    clsController.callback = (p) => {_setStudentsList(p)};
    super.onInit();
  }

  _setStudentsList(String s) {
    studentController.getStudentsList(clsIds: s);
  }

  createObj() {}

  sendMessage() async {
    var stdList = studentController.selectedStudentList
        .map((e) => {
              "UserTypeID": e.sT_ID.toString(),
              "MobileNo": e.guardianMobile.toString()
            })
        .toList();
    stdList.forEach((element) => Get.log(element.toString()));

    var teacherList = employeeController.selectedEmployeeList
        .map((e) => {
              "UserTypeID": e.emp_ID.toString(),
              "MobileNo": e.emp_MobileNo.toString()
            })
        .toList();
    teacherList.forEach((element) => Get.log(element.toString()));

    List<ObjDetails> objList = [];

    //0->Class Wise||1->Student Wise||2->TeacherWise
    var sendMessage = await messageService.sendMessage(
        type: radioIndex.value == 0
            ? MessageType.classwise.name
            : radioIndex.value == 1
                ? MessageType.studentwise.name
                : MessageType.teacherwise.name,
        clsIds: radioIndex.value == 0 ? clsController.classIds.value : "",
        deliveryMobileNo: "",
        objDetailsList: radioIndex.value == 0
            ? []
            : radioIndex.value == 1
                ? stdList
                : teacherList,
        message: message.value.text,
        templateId: templateId);

    if (sendMessage == true) {
      Get.back();
      Ams.ft("Message Send Successfully");
    } else {
      Ams.ft("Message Not Send!!!");
    }
  }
}
