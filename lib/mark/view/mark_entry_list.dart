import 'dart:developer';

import 'package:decora_admin/mark/controller/mark_controller.dart';
import 'package:decora_admin/mark/model/student_mark_model.dart';
import 'package:decora_admin/mark/view/mark_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class MarkEntryList extends GetView<MarkController> {
  const MarkEntryList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getStudentList();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Save'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: ColorManager.primary,
        title: Text(
          "Students List",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: StreamBuilder<StudentMarkModel>(
        stream: controller.markService.studentMarkModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            log("message: is loading");
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorManager.primary,
                size: 100,
              ),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            log("Data: ${data.toString()}");
            return ListView.builder(
              itemCount: data.school?.length ?? 0,
              itemBuilder: (context, index) {
                return MarkCard(
                  colorIndex: index % 3,
                  studentRecord: data.school![index],
                  typeName: data.setting?.first.grade,
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
    );
  }

  void handleClick(String value) {
    switch (value) {
      case "Save":
        controller.saveMark();
        break;
    }
  }
}
