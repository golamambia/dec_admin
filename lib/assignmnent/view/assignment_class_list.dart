import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/assignment_controller.dart';
import '../model/assignment_model.dart';
import 'assignment_add_page.dart';
import 'assignment_card.dart';

class AssignmentClassList extends GetView<AssignmentController> {
  const AssignmentClassList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Assignment",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: StreamBuilder<AssignmentModel>(
        stream: controller.assignmentClassList.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorManager.primary,
                size: 100,
              ),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            log("Data: ${data.toString()}");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.records?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        controller.onAssignmentClassClick(data.records?[index].classID??"");
                      },
                      title: Text(data.records?[index].className??""),
                    ),
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
      
    );
  }


}
