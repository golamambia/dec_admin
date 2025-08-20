import 'package:decora_admin/OnlineCls/controller/online_cls_controller.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/report/controller/report_controller.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart'; 
import 'package:decora_admin/attendance/controller/attendance_controller.dart';


class ReportDownload extends StatelessWidget {
    final String title;
    final String? type;
   ReportDownload({Key? key, required this.title,this.type}) : super(key: key) {
     Get.put(ReportController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportController>();
   // var AttendanceClr=Get.put(AttendanceController());
    var controllerCls=Get.put(OnlineClsController());
 
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          title,
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Date selectors
            if(type=='student_report')
            Padding(
      padding: const EdgeInsets.only(
          top: 30.0, right: 10.0, left: 10.0, bottom: 0),
      child: SingleSelectCls(
      clsId: controller.selectedClassId, // binds selected class
      label: "Select Class",
      clsCallBack: (selectedId) {
        controller.setClassId(selectedId);
      },
      ),
    ),
     if(type=='class_report')
 Padding(
      padding: const EdgeInsets.only(
          top: 30.0, right: 10.0, left: 10.0, bottom: 0),
      child: 
       MultiSelectCls(controller.clsController),
    ),

    if(type=='teacher_report')
 Padding(
      padding: const EdgeInsets.only(
          top: 30.0, right: 10.0, left: 10.0, bottom: 0),
      child: 
        MultiSelectEmployee(employeeController: controller.employeeController),
    ),
    // From/To Date side by side
    Padding(
      padding: const EdgeInsets.only(
          top: 30.0, right: 10.0, left: 10.0, bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: BuildDateTextFormField(
              controller: controller.fromDate,
              label: "From Date",
            ),
          ),
          const SizedBox(width: 10), // spacing between fields
          Expanded(
            child: BuildDateTextFormField(
              controller: controller.toDate,
              label: "To Date",
            ),
          ),
        ],
      ),
    ),
           

            // Download button
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0,bottom: 40),
              child: InkWell(
                onTap: () {
                  // Call your download function here
                  controller.onClickDownload(type);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorManager.primary),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    "DOWNLOAD",
                    textAlign: TextAlign.center,
                    style: getMFStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
