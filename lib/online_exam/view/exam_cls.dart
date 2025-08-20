import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/view/subject/subject_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../resource/color_manager.dart';
import '../../../../../resource/font_manager.dart';
import '../../../../../resource/styles_manager.dart';

class ExamCls extends GetView<ExamController> {
  ExamCls({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchExamClsList();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            Get.back();
            controller.examClsList.value=ExamModel();
            EasyLoading.dismiss();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Exam Class",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: controller.examClsList.stream,
          builder: (context, snapshot) {
            if (snapshot.data==null||snapshot.data!.records==null||snapshot.data!.records!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(fontSize: FontSize.s18),
                  ),
                ),
              );
            }


            return ListView.builder(
              itemCount: snapshot.data!.records?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.class_outlined,
                      size: 30,
                    ),
                    title: Text(
                      "class: ${snapshot.data!.records![i].className}",
                      style: getMFStyle(
                          color: ColorManager.black, fontSize: FontSize.s20),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        controller.clsId.value=snapshot.data!.records![i].classID??"";
                        Get.to(()=>SubjectListPage());
                        // Get.to(() => ExamSubject(
                        //     examId: examId,
                        //     classId: _examService
                        //         .getExamClsData.value.records![i].clasSSTD.toString()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(112.w, 33.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "Subject",
                        style: getMFStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }

}


