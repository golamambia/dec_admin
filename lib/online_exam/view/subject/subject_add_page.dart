import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';

class SubjectAddPage extends GetView<ExamController> {
  SubjectAddPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Save Subject",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SingleSelectSubject(
                        subId: controller.subId,
                        subjectModel: controller.markService.subjectInfoModel,
                        subCallBack: controller.subCallBack),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildDateTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.examDate,
                        label: "Exam Date"),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.objCount,
                        label: "No of objective"),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.objMark,
                        label: "Mark of objective (Q)"),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.desCount,
                        label: "No of descriptive"),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.desMark,
                        label: "Mark of descriptive(Q)"),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTimeTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.timeIn,
                        inputType: TextInputType.datetime,
                        label: "Time-In"),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildTimeTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.timeOut,
                        inputType: TextInputType.datetime,
                        label: "Time-Out"),SizedBox(
                      height: 10.h,
                    ),
                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        inputType: TextInputType.number,
                        controller: controller.passMark,
                        label: "Passing Mark"),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.onSaveExamSubject();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(240.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Text(
                        "Save",
                        style: getMFStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Obx _buildSelectionTextField({
    required List<String> days,
    required Rx<String> dayType,
    String? Function(String?)? vfn,
  }) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
        value: dayType.isEmpty ? null : dayType.value,
        hint: Text(
          'Please Select Day Type',
          style: getRFStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        ),
        validator: vfn,
        isExpanded: true,
        style: getRFStyle(color: ColorManager.black, fontSize: FontSize.s14),
        items: days
            .map(
              (val) => DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                  style: getRFStyle(
                      color: ColorManager.black, fontSize: FontSize.s14),
                ),
              ),
            )
            .toList(),
        onChanged: (String? val) {
          dayType.value = val ?? "";
        },
      ),
    );
  }
}
