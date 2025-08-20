import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../resource/color_manager.dart';
import '../resource/font_manager.dart';
import '../resource/styles_manager.dart';
class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Coming soon",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(child:
          Text("Coming soon!!!"),),
      ),
    );
  }
}
