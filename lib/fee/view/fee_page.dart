import 'package:decora_admin/fee/controller/fee_controller.dart';
import 'package:decora_admin/fee/model/student_search_model.dart';
import 'package:decora_admin/fee/view/fee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/view/common_view.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class FeePage extends GetView<FeeController> {
  const FeePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FeeController());
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
          "Fee Details",
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
                            const Text("Student Wise"),
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
                            const Text("Class Wise"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () {
                        if (controller.radioIndex.value == 1) {
                          return Column(
                            children: [
                              MultiSelectCls(controller.clsController),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    MultiSelectInstallment(controller.installmentController),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () {
                        if (controller.radioIndex.value == 0) {
                          return Column(
                            children: [
                              BuildTextFormField(
                                controller: controller.searchItem,
                                label: "Student Search",
                                onChanged: (p0) {
                                  controller.fetchStudentDetails();
                                },
                              ),
                              StreamBuilder(
                                stream: controller.studentModel.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting &&
                                      snapshot.connectionState ==
                                          ConnectionState.active) {
                                    return Container(
                                      color: ColorManager.white,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      width: double.infinity,
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasData &&
                                      controller.searchItem.text.isNotEmpty) {
                                    var data = snapshot.data!;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                          width: double.infinity,
                                          height: controller.studentModel.value
                                                      .records!=null&&controller.studentModel.value
                                              .records?.length!=0
                                              ? 200.h
                                              : 0.h,
                                          decoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5.0,
                                                )
                                              ]),
                                          child: ListView.builder(
                                            itemCount:data.records?.length??0 ,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.searchItem.text =
                                                        data.records![index]
                                                            .label!;
                                                    controller.stdId =data.records![index].value!;
                                                    controller.studentModel
                                                        .value = StudentSearchModel();

                                                  },
                                                  child: Column(
                                                    children: [
                                                      Text(data.records?[index]
                                                              .label ??
                                                          ""),
                                                      Divider()
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),

/*                    BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.installIds,
                        label: "Installments"),
                    SizedBox(
                      height: 10.h,
                    ),*/
                    /*  BuildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.details,
                        label: "Assignment Details",
                        minLine: 4),
                    SizedBox(
                      height: 10.h,
                    ),*/
                    BuildDateTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.date,
                        label: "Current Date"),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // // controller.onFectch();
                        // controller.getDetails();
                        Get.to(()=> FeeList());

                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(240.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Text(
                        "Get Details",
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
}
