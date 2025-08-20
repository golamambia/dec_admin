import 'dart:math';

import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/dashboard/view/custom_drawer.dart';
import 'package:decora_admin/dashboard/view/home.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dashboard extends GetView<DashboardController> {
 const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      extendBody: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Obx(
                () => AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    width: 288.w,
                    left: controller.isSideBarOpen.value ? 0 : -288,
                    height: MediaQuery.of(context).size.height - 30,
                    child: CustomDrawer()),
              ),
              AnimatedBuilder(
                animation: controller.animationController!,
                builder: (context, child) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(controller.animationPosition!.value -
                        20 * controller.animationPosition!.value * pi / 180),
                  child: Transform.translate(
                    offset:
                        Offset(controller.animationPosition!.value * 250, 0),
                    child: Transform.scale(
                        scale: controller.animationScale?.value,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                controller.isSideBarOpen.value ? 10.0 : 0.0),
                            child: Home())),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
