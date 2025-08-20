import 'package:decora_admin/common/controller/student_controller.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/message/controller/message_controller.dart';
import 'package:decora_admin/message/view/TemplateDropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/bulletin_controller.dart';
class BulletinPage extends GetView<BulletinController> {
  const BulletinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            // controller.reset();
            Get.back();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Bulletin",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(width: double.infinity,height: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Obx(() => Radio<int>(
                      value: 0,
                      groupValue: controller.radioIndex.value,
                      onChanged: (value) {
                        controller.radioIndex.value = value!;
                      },
                    )),
                    // SizedBox(width: 5.0),
                    const Text("Class"),
                  ],
                ),
                Row(
                  children: [
                    Obx(() => Radio<int>(
                      value: 1,
                      groupValue: controller.radioIndex.value,
                      onChanged: (value) {
                        controller.radioIndex.value = value!;
                      },
                    )),
                    // SizedBox(width: 5.0),
                    const Text("Student"),
                  ],
                ),
                Row(
                  children: [
                    Obx(() => Radio<int>(
                      value: 2,
                      groupValue: controller.radioIndex.value,
                      onChanged: (value) {
                        controller.radioIndex.value = value!;
                      },
                    )),
                    // SizedBox(width: 5.0),
                    const Text("Teacher"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            Obx(() {
              if(controller.radioIndex.value==2){
                return SizedBox.shrink();
              }
              return Column(children: [
                MultiSelectCls(controller.clsController),
                SizedBox(height: 10.h,),
              ],);
            },),
            Obx(() {
              if(controller.radioIndex.value!=1){
                return SizedBox.shrink();
              }
              return Column(children: [
                MultiSelectStudents(studentController: controller.studentController),
                SizedBox(height: 10.h,),
              ],);
            },),
            Obx(() {
              if(controller.radioIndex.value!=2){
                return SizedBox.shrink();
              }
              return Column(children: [
                MultiSelectEmployee(employeeController: controller.employeeController),
                SizedBox(height: 10.h,),
              ],);
            },),
            SizedBox(
              height: 10.h,
            ),
            BuildTextFormField(controller: controller.title.value, label: "Title",minLine: 1),
            SizedBox(height: 10.h,),
            BuildTextFormField(controller: controller.bulletin.value, label: "Bulletin...",minLine: 2),
            SizedBox(height: 10.h,),
            ElevatedButton(
              onPressed: () {
                controller.sendBulletin();
          
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  backgroundColor: ColorManager.primary,
                  minimumSize: Size(240.w, 40.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: Text(
                "Send Bulletin",
                style: getMFStyle(
                    color: ColorManager.white, fontSize: FontSize.s14),
              ),
            ),
          
          ],),
        ),),
      ),
    );
  }
}
