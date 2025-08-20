import 'dart:developer';

import 'package:decora_admin/homework/controller/home_work_controller.dart';
import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/homework/view/home_work_add_page.dart';
import 'package:decora_admin/homework/view/home_work_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
class HomeWorkList extends GetView<HomeWorkController> {
  const HomeWorkList({super.key});

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
          "Home Work",
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

      body: StreamBuilder<HomeWorkModel>(
        stream: controller.homeworkModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
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
              itemCount: data.records?.length ?? 0,
              itemBuilder: (context, index) {
                return HomeWorkCard(
                  colorIndex: index%3,
                  homeWorkRecord: data.records![index],
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
          controller.reset();
          await Get.to(() => HomeWorkAddPage());
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

        controller.fetchData();
        break;
      case  'Up coming':
        controller.fetchData();

        break;
    }
  }
}
