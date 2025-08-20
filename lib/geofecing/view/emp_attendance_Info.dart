import 'package:decora_admin/geofecing/view/auto_emp_attendance.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../controller/emp_attendance_controller.dart';
import 'emp_attendance.dart';

class EmpAttendanceInfo extends GetView<EmpAttendanceController> {
  EmpAttendanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: ColorManager.white,
            onPressed: () {
              // controller.reset();
              EasyLoading.dismiss();
              Get.back();
            },
          ),
          backgroundColor: ColorManager.primary,

          title: Container(
            width: double.infinity,
            child: TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              indicatorColor: ColorManager.white,
              tabs: [
                Tab(
                  child: Text(
                    "Auto Attendance",
                    style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s12),
                  ),
                ),
                Tab(
                  child: Text(
                    "View All",
                    style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s12),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AutoEmpAttendance(),
            EmpAttendance(),
          ],
        ),
      ),
    );
  }
}

