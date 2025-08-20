import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/home_work_controller.dart';
import '../model/home_work_model.dart';

import 'home_work_card.dart';
import 'homework_card_for_stu.dart';

class HomeWorkByClassList extends GetView<HomeWorkController> {
  const HomeWorkByClassList({super.key});

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
          "HomeWork",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: StreamBuilder<HomeWorkModel>(
        stream: controller.homeWorkByClassModel.stream,
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
            return ListView.builder(
              itemCount: data.records?.length ?? 0,
              itemBuilder: (context, index) {
                return HomeworkCardForStu(
                  colorIndex: index % 3,
                  homeWorkRecord: data.records![index],
                  activeView: false,
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


}
