/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resource/color_manager.dart';
import '../resource/font_manager.dart';
import '../resource/styles_manager.dart';
import 'geofencing_controller.dart';

class GeofecingPage extends GetView<GeofencingController> {
  const GeofecingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          "GeoFacing",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text("please wait..."),
        ),
      ),
    );
  }
}
*/
