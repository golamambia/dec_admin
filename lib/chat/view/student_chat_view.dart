import 'package:decora_admin/chat/controller/chat_controller.dart';
import 'package:decora_admin/chat/view/chat_room.dart';
import 'package:decora_admin/common/model/employee_model.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/model/student_model.dart';


class StudentChatView extends GetView<ChatController> {
  StudentChatView({Key? key}) : super(key: key);


  var userId = getStringAsync("userId");
  var schoolCode = getStringAsync("schoolCode");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SingleSelectCls(clsId: controller.clsId),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => FutureBuilder(
                future: controller.chatService.getChatStudentList(clsId:controller.clsId.value),
                builder: (_, sn) {
                  if (sn.connectionState==ConnectionState.waiting)
                    return Column(
                      children: [
                        LinearProgressIndicator(),
                      ],
                    );

                  // var res = sn.data as ChatListModel;
                  return ListView.builder(
                    // scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.chatService.teacherModel.value.records.length,
                    itemBuilder: (_, index) {
                      return _teacherCard(
                          record: controller.chatService.teacherModel.value.records[index],
                          empId: controller.chatService.teacherModel.value.records[index].sT_ID.toInt()
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }

  _teacherCard({required StudentRecord record,required int empId}) {
    // var split=record.emp_Name?.split(',');


    return Card(
      // color: (empId==6)?Colors.blueGrey:null,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            var senderId = "${schoolCode.toUpperCase()}_S_${userId}";
            // var receiverId="${schoolCode.toUpperCase()}_S_${userId}";
            print("Uid: "+record.user_ID!.toUpperCase());

            controller.setReceiverUser(record.user_ID!);
            controller.setReceiverId(record.user_ID!);
            controller.setCurrentTeacherFromList(record);



            Get.to(()=>ChatRoom(imageUrl: "${EndPoints.baseDownloadUrl+record.photo!}"));
          },
          leading: Container(
            clipBehavior: Clip.antiAlias,
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Ams().imageWidget(EndPoints.baseDownloadUrl+record.photo!, fit: BoxFit.fill),
          ),
          title: Text(
            "${record.sT_Name}",

            style: getMFStyle(color: Colors.black, fontSize: FontSize.s18),
          ),
        ),
      ),
    );
  }
}
