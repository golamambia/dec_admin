import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/service/exam_service.dart';
import 'package:decora_admin/online_exam/view/exam_add_page.dart';
import 'package:decora_admin/online_exam/view/exam_card.dart';
import 'package:decora_admin/online_exam/view/subject/subRecord.dart';
import 'package:decora_admin/online_exam/view/subject/subject_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common/view/common_view.dart';
import '../../../resource/color_manager.dart';
import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';
import '../../controller/exam_controller.dart';

class SubjectListPage extends GetView<ExamController> {
  const SubjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchSubList();
    controller.fetchExamSubList();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Subject List",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleSelectSubject(
                subId: controller.subId,
                subjectModel: controller.markService.subjectInfoModel,
                subCallBack: controller.subCallBack),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: StreamBuilder<ExamModel>(
              stream: controller.examSubList.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"));
            
                } else if (snapshot.hasData) {
                  var data = snapshot.data!;
                  // log("Data: ${data.toString()}");
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.records?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SubRecordItme(
                          examRecord: data.records![index],
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: Text("No Data"));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () async {
          controller.resetSubjectForm();
          await Get.to(() => SubjectAddPage());
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
        controller.fetchSubList();
        break;
      case 'Up coming':
        controller.fetchSubList();

        break;
    }
  }
}
