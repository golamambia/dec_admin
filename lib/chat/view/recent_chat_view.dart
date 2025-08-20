import 'package:decora_admin/chat/controller/chat_controller.dart';
import 'package:decora_admin/chat/model/RecentObjModel.dart';
import 'package:decora_admin/chat/view/chat_room.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecentChatView extends GetView<ChatController> {
  RecentChatView({Key? key}) : super(key: key);

  // var _firebaseService = Get.put(FireBaseService(userId: '', receiverId: ''));

  itemsObj(Map<String, dynamic> map){
    return RecentObjModel.fromJson(map);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.recentCollReference(controller.currentUserId).orderBy("createdAt",descending: true).snapshots(),
        builder: (context, snapshot) {
          var list = <RecentObjModel>[];


          if (snapshot.hasData)
            snapshot.data?.docs.forEach((element) {
              list.add(itemsObj(element.data()));
            });

          return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // var split = list[index].detail?.name?.split(',');

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      controller.setReceiverUser(list[index].detail!.uid!);
                      controller.setReceiverId(list[index].detail!.uid!);
                      controller.setCurrentTeacherFromRecent(list[index]);
                      Get.to(()=>ChatRoom(imageUrl: list[index].detail!.img));

                    },
                    leading: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Ams().imageWidget(list[index].detail?.img,
                          fit: BoxFit.fill),
                    ),
                    title: Text(
                      "${list[index].detail?.name}",
                      style: getMFStyle(
                          color: Colors.black, fontSize: FontSize.s18),
                    ),
                    subtitle: Text(
                      list[index].text ?? "",
                      style: getMFStyle(
                          color: Colors.blueGrey, fontSize: FontSize.s16),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
