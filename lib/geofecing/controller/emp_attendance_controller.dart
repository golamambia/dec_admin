import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../dashboard/service/dashboard_service.dart';
import '../service/emp_attendance_service.dart';

class EmpAttendanceController extends GetxController {
  final service = Get.put(EmpAttendanceService());
  var dashboardService = Get.put(DashboardService());

  var latitude = TextEditingController();
  var longitude = TextEditingController();

  Future<void> updateCurrentLocation() async {
    var currentPosition = await _determinePosition();
    latitude.text = currentPosition.latitude.toString();
    longitude.text = currentPosition.longitude.toString();
  }

  takeAutoAttendance() async {
    var isEnable = await Geolocator.isLocationServiceEnabled();
    if (!isEnable) {
      Ams.ft("Please Enable gps service", bgColor: ColorManager.stateDanger);
      return;
    }
    /*
    22.852700,88.410211
    * */

    // Position(
    //     latitude: 22.852700,
    //     longitude: 88.410211,
    //     timestamp: DateTime.timestamp(),
    //     accuracy: 20,
    //     altitude: 0,
    //     altitudeAccuracy: 0,
    //     heading: 0,
    //     headingAccuracy: 45.0,
    //     speed: 0,
    //     speedAccuracy: 1.5);

    var currentPosition = await _determinePosition();
    // Get.log("Current position latitude : ${currentPosition.latitude}");
    // Get.log("Current position longitude : ${currentPosition.longitude}");
    // Get.log("Current position timestamp : ${currentPosition.timestamp}");
    // Get.log("Current position accuracy : ${currentPosition.accuracy}");
    // Get.log("Current position altitude : ${currentPosition.altitude}");
    // Get.log("Current position altitudeAccuracy : ${currentPosition.altitudeAccuracy}");
    // Get.log("Current position heading : ${currentPosition.heading}");
    // Get.log("Current position headingAccuracy : ${currentPosition.headingAccuracy}");
    // Get.log("Current position speed : ${currentPosition.speed}");
    // Get.log("Current position speedAccuracy : ${currentPosition.speedAccuracy}");

    double distanceBetween = Geolocator.distanceBetween(double.parse(dashboardService.dashboardModel.value.locationSettings?.first.latitude??"0.0"),double.parse(dashboardService.dashboardModel.value.locationSettings?.first.longitude??"0.0"),
        currentPosition.latitude, currentPosition.longitude);

    if (distanceBetween < 30) {
      Get.log("Current position distance : ${distanceBetween}");
      Get.log("Current position distance : ${distanceBetween}");
      Get.log("${double.parse(dashboardService.dashboardModel.value.locationSettings?.first.latitude??"0.0")}");
      Get.log("${currentPosition.latitude}");
      Get.log("${double.parse(dashboardService.dashboardModel.value.locationSettings?.first.longitude??"0.0")}");
      Get.log("${currentPosition.longitude}");
      var saveStatus = await service.saveAutoEmpAttendance();
      if (saveStatus) {
        service.getTodayEmpAttendanceInfo();
      }
    } else {
      Get.log("Current position distance : ${distanceBetween}");
      Get.log("${double.parse(dashboardService.dashboardModel.value.locationSettings?.first.latitude??"0.0")}");
      Get.log("${currentPosition.latitude}");
      Get.log("${double.parse(dashboardService.dashboardModel.value.locationSettings?.first.longitude??"0.0")}");
      Get.log("${currentPosition.longitude}");
      _showDialoge();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    EasyLoading.show();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Ams.ft("please provide the location permission for Auto Attendance!!!",
            bgColor: ColorManager.stateDanger);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var currentPosition = await Geolocator.getCurrentPosition();

    if (currentPosition != null) {
      EasyLoading.dismiss();
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return currentPosition;
  }

  void saveLocation() async {
    var status = await service.saveLocation(
        latitude: latitude.text, longitude: longitude.text);
    if (status) {
      Ams.ft("saved successfully");
      Get.back();
    }
  }

  void _showDialoge() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      desc: "You can't give attendance out of the decided coverage area.",
      showCloseIcon: true,
      autoDismiss: true,
      title: "Out of Coverage Area",
    ).show();
  }
}
