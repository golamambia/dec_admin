import 'package:decora_admin/notice/controller/notice_controller.dart';
import 'package:decora_admin/notice/model/notice_model.dart';
import 'package:decora_admin/notice/service/notice_type.dart';
import 'package:decora_admin/notice/view/notice_card.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:skeletonizer/skeletonizer.dart';

import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import 'notice_add_page.dart';

class NoticePage extends StatefulWidget {
  NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var controller = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "School Notice",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Get All','Get Past', 'Up coming'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<NoticeModel>(
        stream: controller.noticeModel.stream,
        builder: (context, snapshot) {
          controller.count = 0;
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
              return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorManager.primary,
                size: 100,
              ),
            );;
          }

          else if (snapshot.hasData) {
            var data=snapshot.data;
            return ListView.builder(
              itemCount: data?.records?.length ?? 0,
              itemBuilder: (context, index) {
                return NoticeCard(
                  noticeRecord: controller.noticeModel.value.records![index],
                  colorIndex: index%3,
                  refresh: () {
                    controller.fetchData();
                  },
                );
              },
            );
          }
          return const Center(child: Text("NO Data!!!"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () async {
          controller.reset();
          await Get.to(() => NoticeAddPage());
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
      case "Get All":
        controller.noticeType.value = NoticeType.GetAllNoticePast;

        break;case "Get Past":
      controller.noticeType.value = NoticeType.GetAllNoticePast;

      break;
      case 'Up coming':
        controller.noticeType.value = NoticeType.GetAllNoticeUpcoming;

        break;
    }
  }
}
