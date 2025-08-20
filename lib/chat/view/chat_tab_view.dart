import 'package:decora_admin/chat/view/recent_chat_view.dart';
import 'package:decora_admin/chat/view/student_chat_view.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTabView extends StatelessWidget {
  const ChatTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: ColorManager.white,
            onPressed: () => Get.back(),
          ),
          bottom:  TabBar(isScrollable: false, tabs: [
            Tab(
              child: Text("Recent",style: getMFStyle(
                  color: ColorManager.white, fontSize: FontSize.s14),),
            ),
            Tab(
              child: Text("Student", style: getMFStyle(
                  color: ColorManager.white, fontSize: FontSize.s14),
                  ),
            ),
          ]),
          backgroundColor: ColorManager.primary,
          title: Text(
            "Chat List",
            style:
            getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
          ),
        ),
        body: TabBarView(
          children: [
            RecentChatView(),
            StudentChatView(),
            // Center(child:Text("Empty")),
          ],
        ),
      ),
    );
  }
}
