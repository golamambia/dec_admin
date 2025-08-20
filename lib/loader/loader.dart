import 'package:decora_admin/loader/customAnimation.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MLoader {
  static void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..contentPadding = EdgeInsets.all(5)
      ..radius = 80.0
      ..progressColor = ColorManager.primary
      ..backgroundColor = Colors.white
      ..indicatorColor = ColorManager.primary
      ..textColor = ColorManager.primary
      ..maskColor = Colors.black
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }
}
