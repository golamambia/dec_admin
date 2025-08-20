import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/service/exam_service.dart';
import 'package:decora_admin/online_exam/view/exam_card.dart';
import 'package:decora_admin/online_exam/view/subject/subject_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/exam_controller.dart';
import 'exam_add_page.dart';

class OnlineExamList extends GetView<ExamController> {
  const OnlineExamList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchExam();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Exam List",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Get Past', 'Up coming'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<ExamModel>(
        stream: controller.examModel.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorManager.primary,
                size: 100,
              ),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            // log("Data: ${data.toString()}");
            return ListView.builder(
              itemCount: data.records?.length ?? 0,
              itemBuilder: (context, index) {
                return ExamCard(
                  colorIndex: index % 3,
                  examRecord: data.records![index],
                  activeView: true,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: Text("No Data"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () async {
          controller.resetExamForm();
          await Get.to(() => ExamAddPage());
          // await Get.to(() => SubjectListPage());
        },
        child: Icon(
          Icons.add,
          size: 32.h,
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case "Get Past":
        controller.currentExamType = ExamType.SelectExamPastApp;
        controller.fetchExam();
        break;
      case 'Up coming':
        controller.currentExamType = ExamType.SelectExamUpcomingApp;
        controller.fetchExam();
        break;
    }
  }
}
