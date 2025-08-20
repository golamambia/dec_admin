import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/dashboard/view/dashboard.dart';
import 'package:decora_admin/localPin/view/local_pin.dart';
import 'package:decora_admin/login/model/login_model.dart';
import 'package:decora_admin/login/service/login_service.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

import '../../splash/SplashPage.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var schoolCode = TextEditingController();
  var mobileNo = TextEditingController();
  var password = TextEditingController();
  LoginModel? loginModel = LoginModel();

  final LoginService _loginService = Get.put(LoginService());

  void login() async {
    if (formKey.currentState!.validate()) {
      loginModel = await _loginService.postLogin(
          schoolCode: schoolCode.text,
          mobile: mobileNo.text,
          password: password.text);
      if (loginModel != null) {
        _showAwesomeDialog();
      }
    }
  }

  void _showAwesomeDialog() {
    var context = Get.context!;
    Ams.dialogSuccess(
      context: context,
      title: "Successful",
      message: "do you want to set Pin, for two step verification ?",
      btnOkOnPress: () {
        Navigator.of(context).pop();
        var record = loginModel?.records;
        CommonService.saveAllVale(
            employeeId: record!.emp_ID,
            branchCode: record.branchCode,
            userId: record.user_ID,
            branchId: record.branchID,
            mobile: record.emp_MobileNo,
            schoolCode: record.schoolCode,
            currentSessionId: record.currentSessionId,
            employeeTypeId: record.emp_TypeID);
        Get.off(() => LocalPin());
      },
      btnCancelOnPress: () async{
        Navigator.of(context).pop();
        var record = loginModel?.records;
        await CommonService.saveAllVale(
            employeeId: record!.emp_ID,
            branchCode: record.branchCode,
            userId: record.user_ID,
            branchId: record.branchID,
            mobile: record.emp_MobileNo,
            schoolCode: record.schoolCode,
            employeeTypeId: record.emp_TypeID,
            currentSessionId: record.currentSessionId
        );
        // await Get.put(DashboardController());
        Future.delayed(Duration(seconds: 2));
        await Get.off(() => Dashboard(),binding: BindingsBuilder.put(()=>DashboardController())
        );

      },
      onDismissCallback: (dt) => {
        // if (dt == DismissType.btnOk)
        //   {print("press ok")}
        // else if ((dt == DismissType.btnCancel))
        //   {
        //     Get.log("cancel")
        //   }
      },
    ).show();
  }
}
