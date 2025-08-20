import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:decora_admin/dashboard/service/dashboard_service.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../common/common_service.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isSideBarOpen = false.obs;
  var dashboardService = Get.put(DashboardService());
  final CommonService _commonService = Get.put(CommonService());

  late StreamSubscription<InternetStatus> listener;
  bool isWaring = false;

  final Rxn<AnimationController> _animationController =
      Rxn<AnimationController>();

  final Rxn<Animation<double>> _positionAnimation = Rxn<Animation<double>>();
  final Rxn<Animation<double>> _scaleAnimation = Rxn<Animation<double>>();

  AnimationController? get animationController => _animationController.value;

  Animation<double>? get animationPosition => _positionAnimation.value;

  Animation<double>? get animationScale => _scaleAnimation.value;

  @override
  void onInit() {
    _animationController.value =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            update();
          });

    _positionAnimation.value = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _animationController.value!, curve: Curves.fastOutSlowIn));

    _scaleAnimation.value = Tween<double>(
      begin: 1,
      end: .8,
    ).animate(CurvedAnimation(
        parent: _animationController.value!, curve: Curves.fastOutSlowIn));

   /* listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          if (isWaring) {
            Get.back();
            isWaring = false;
          }
          break;
        case InternetStatus.disconnected:
          isWaring = true;
          _showAwesomeDialog();
          break;
      }
    });*/

    super.onInit();
  }

  @override
  void onClose() {
    _animationController.value?.dispose();
    listener.cancel();
    super.onClose();
  }

  void toggleSidebar() {
    isSideBarOpen.value = !isSideBarOpen.value;
    switch (isSideBarOpen.value) {
      case true:
        _animationController.value?.forward();
        break;
      case false:
        _animationController.value?.reverse();
        break;
    }
  }

  void _showAwesomeDialog() {
    var context = Get.context!;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "Internet Problem",
      desc: "Please turn on internet connection",
      buttonsTextStyle:
          getBFStyle(color: ColorManager.primary, fontSize: FontSize.body),
      onDismissCallback: (DT) {},
      showCloseIcon: false,
      autoDismiss: false,
      btnOkOnPress: null,
    ).show();
  }
}
