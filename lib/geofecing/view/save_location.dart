
import 'dart:math';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/geofecing/controller/emp_attendance_controller.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class SaveLocation extends GetView<EmpAttendanceController> {
  const SaveLocation({super.key});

  @override
  Widget build(BuildContext context) {
    controller.updateCurrentLocation();
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
          "Save Location",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: CustomMaterialIndicator(
        onRefresh: () {
          return controller.updateCurrentLocation();
        }, // Your refresh logic
        backgroundColor: Colors.white,
        indicatorBuilder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircularProgressIndicator(
              color: Colors.redAccent,
              value: controller.state.isLoading ? null : min(controller.value, 1.0),
            ),
          );
        },
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            SizedBox(height: 10.h,),
            Center(child: Text("Drag down for refresh location",style: getMFStyle(color: ColorManager.green, fontSize: FontSize.s14),)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: ColorManager.green,),
            ),
            Ams().imageWidget(ImageAssets.map),
            SizedBox(height: 10.h,),
            BuildTextFormField(
                controller: controller.latitude, label: "Latitude"),
            SizedBox(
              height: 10.h,
            ),
            BuildTextFormField(
                controller: controller.longitude, label: "Longitude"),
            SizedBox(height: 10.h),
            Center(
              child: ElevatedButton.icon(
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: ()  async {
                    controller.saveLocation();
                  },
                  label: Text("Save Location")),
            )
          ],
        ),
      ),
    );
  }
}
