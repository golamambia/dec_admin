import 'package:decora_admin/bulletin/service/bulletin_service.dart';
import 'package:decora_admin/bulletin/service/bulletin_type.dart';
import 'package:decora_admin/common/controller/student_controller.dart';
import 'package:decora_admin/common/employee_controller.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/controller/cls_controller.dart';

class BulletinController extends GetxController {
  var studentController = StudentController();
  var employeeController = EmployeeController();
  var clsController = ClsController();
  var bulletinService = Get.put(BulletinService());

  //0->Class Wise||1->Student Wise||2->TeacherWise

  var radioIndex = 0.obs;
  String templateId = "";

  var bulletin = TextEditingController().obs;
  var title = TextEditingController().obs;

  @override
  void onInit() {
    clsController.callback = (p) => {_setStudentsList(p)};
    super.onInit();
  }

  _setStudentsList(String s) {
    studentController.getStudentsList(clsIds: s);
  }

  sendBulletin() async {
    var bulletinModel = await bulletinService.sendBulletin(
        type: BulletinType.SaveBulletin,
        userIds: radioIndex == 0
            ? ""
            : radioIndex.value == 1
                ? studentController.studentsIds.value
                : employeeController.empIds.value,
        senderType:radioIndex==0?SenderType.Class:radioIndex==1?SenderType.Student:SenderType.Teacher,
        title: title.value.text,
        clsIds: radioIndex == 0 ? clsController.classIds.value : "",
        msgBody: bulletin.value.text);
    if (bulletinModel.status == true) {
      Ams.ft("Notification sent");
      Get.back();
    }
  }
}
