import 'package:decora_admin/notification/controller/notification_controller.dart';
import 'package:decora_admin/notification/model/notification_model.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.notificationService.getNotificationList();
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
            "Notification",
            style:
                getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
          ),
          /*actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Teacher', 'Student'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],*/
        ),
        body: StreamBuilder(
            stream: controller.notificationModel.stream,
            builder: (context, AsyncSnapshot<NotificationModel> snapshot) {
              if (snapshot.data == null ||
                  snapshot.data!.records == null ||
                  snapshot.data!.records!.isEmpty) {
                return Column(
                  children: [Expanded(child: Center(child: Text("NO Data")))],
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.records.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  var data = snapshot.data?.records[i];
                  return _notificationCard(i, data);
                },
              );
            }));
  }

  Card _notificationCard(int i, NotificationRecord? data) {
    return Card(
      margin: EdgeInsets.all(10),
      color: ColorManager.primaryLight,
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading:
                Icon(Icons.album, color: Ams.cardTitleColor[i % 3], size: 45),
            title: Text(
              "${data?.title} (${data?.createdDate})",
              style:
                  getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
            ),
            subtitle: Text('${data?.msgBody}'),
          ),
        ],
      ),
    );
  }

  /*void handleClick(String value) {
    switch (value) {
      case "My Notification":

        controller.fetchData();
        break;
      case  'Find Notification':
        controller.fetchData();

        break;
    }
  }*/
}
