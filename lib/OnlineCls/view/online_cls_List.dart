import 'dart:developer';



import 'package:decora_admin/OnlineCls/service/online_cls_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/online_cls_controller.dart';
import '../model/online_cls_model.dart';
import 'online_cls_add_page.dart';
import 'online_cls_card.dart';
class OnlineClsList extends GetView<OnlineClsController> {
  const OnlineClsList({super.key});

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
          "Online Class",
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

      body: StreamBuilder<OnlineClsModel>(
        stream: controller.onlineClsModel.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                return OnlineClsCard(
                  colorIndex: index%3,
                  onlineClsRecord: data.records![index],
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
          await Get.to(() => OnlineClsAddPage());
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
        controller.onlineClsType.value=OnlineClsType.GetAllAPastOnlineClass;
        controller.fetchData();
        break;
      case  'Up coming':
        controller.onlineClsType.value=OnlineClsType.GetAllUpcommingOnlineClass;
        controller.fetchData();

        break;
    }
  }
}
