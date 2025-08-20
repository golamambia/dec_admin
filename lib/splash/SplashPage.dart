import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/dashboard/view/dashboard.dart';
import 'package:decora_admin/dashboard/view/home.dart';
import 'package:decora_admin/localPin/view/local_pin.dart';
import 'package:decora_admin/login/view/login.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../resource/color_manager.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    _next();
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(child: Image.asset(ImageAssets.logo)),
    );
  }

  _next() async {
    var employeeId = getStringAsync("employeeId", defaultValue: "");
    var branchCode = getStringAsync("branchCode", defaultValue: "");
    var branchId = getStringAsync("branchId", defaultValue: "");
    var mobile = getStringAsync("mobile", defaultValue: "");
    var schoolCode = getStringAsync("schoolCode", defaultValue: "");
    var localPin = getStringAsync("localPin", defaultValue: "");
    var employeeTypeId = getStringAsync("employeeTypeId", defaultValue: "");
    var currentSessionId = getStringAsync("currentSessionId", defaultValue: "");

    //required to load all local save data;
    await CommonService.getAllLocalData();

    await Future.delayed(const Duration(seconds: 2));
    //need to for dashboard
    if(localPin.isNotEmpty){
      Get.off(()=>LocalPin());
    }
    else if (schoolCode.isNotEmpty &&
        mobile.isNotEmpty &&
        branchCode.isNotEmpty &&
        employeeId.isNotEmpty) {
      await Get.off(() => Dashboard(),binding: BindingsBuilder.put(()=>DashboardController()));
    }else{
      Get.off(()=> LoginPage());
    }

    // Get.off(() => LoginPage());
  }
}
