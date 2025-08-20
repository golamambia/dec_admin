import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/mark/controller/mark_controller.dart';
import 'package:decora_admin/mark/view/mark_entry_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class MarkForm extends GetView<MarkController> {
  const MarkForm({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Mark Entry",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SingleSelectCls(
                  clsId: controller.clsId, clsCallBack: controller.clsCallBack),
              SizedBox(
                height: 10.h,
              ),
              SingleSelectSubject(
                  subId: controller.subId,
                  subjectModel: controller.markService.subjectInfoModel,
                  subCallBack: controller.subCallBack),
              SizedBox(
                height: 10.h,
              ),
              SingleSelectExam(
                  examId: controller.examId,
                  examModel: controller.markService.examInfoModel,examCallBack: controller.examCallback ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(controller.formKey.currentState!.validate()){
                    await controller.getStudentList();
                    Get.to(()=>MarkEntryList());
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    backgroundColor: ColorManager.primary,
                    minimumSize: Size(240.w, 40.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                child: Text(
                  "Fetch Students",
                  style: getMFStyle(
                      color: ColorManager.white, fontSize: FontSize.s14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
