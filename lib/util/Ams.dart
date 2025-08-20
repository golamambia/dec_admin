import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/attendance/view/attendance.dart';
import 'package:decora_admin/bulletin/controller/bulletin_controller.dart';
import 'package:decora_admin/bulletin/view/bulletin_page.dart';
import 'package:decora_admin/geofecing/controller/emp_attendance_controller.dart';
import 'package:decora_admin/geofecing/view/emp_attendance_Info.dart';
import 'package:decora_admin/geofecing/view/save_location.dart';
import 'package:decora_admin/homework/controller/home_work_controller.dart';
import 'package:decora_admin/homework/view/home_work_List.dart';
import 'package:decora_admin/mark/controller/mark_controller.dart';
import 'package:decora_admin/mark/view/mark_form.dart';
import 'package:decora_admin/message/controller/message_controller.dart';
import 'package:decora_admin/message/view/message_page.dart';
import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/online_exam/view/online_exam_list.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/splash/SplashPage.dart';
import 'package:decora_admin/syllbus/view/syllabus_List.dart';
import 'package:decora_admin/util/Icon_type.dart';
import 'package:decora_admin/util/coming_soon.dart';
import 'package:decora_admin/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' hide DialogType;

import '../OnlineCls/controller/online_cls_controller.dart';
import '../OnlineCls/view/online_cls_List.dart';
import '../assignmnent/controller/assignment_controller.dart';
import '../assignmnent/view/assignment_List.dart';
import '../attendance/view/emp_attendance.dart';
import '../syllbus/controller/syllabus_controller.dart';

class Ams {
  Widget imageWidget(String? url,
      {double? height, double? width, BoxFit? fit, Color? color}) {
    if (url.validate().startsWith('http')) {
      if (isMobile) {
        return CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
          imageUrl: '$url',
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
      } else {
        return Image.network(url!, height: height, width: width, fit: fit);
      }
    } else {
      return Image.asset(url!, height: height, width: width, fit: fit);
    }
  }

  static ft(title, {Color? bgColor}) => toast(
        title,
        bgColor: bgColor ?? ColorManager.primary,
      );

  static AwesomeDialog dialogCancel(
      {required BuildContext context,
      required String message,
      void Function()? btnOkOnPress}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "Cancel",
      desc: message,
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      autoDismiss: true,
      btnOkOnPress: btnOkOnPress,
    );
  }

  static AwesomeDialog dialogFail(
      {required BuildContext context,
      required String message,
      required title}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      autoDismiss: true,
      btnOkOnPress: null,
    );
  }

  static AwesomeDialog dialogSuccess(
      {required BuildContext context,
      required String title,
      required String message,
      void Function()? btnOkOnPress,
      void Function()? btnCancelOnPress,
      required Function(DismissType)? onDismissCallback}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      onDismissCallback: onDismissCallback,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: false,
      autoDismiss: false,
      btnCancel: ElevatedButton(
        onPressed: btnCancelOnPress,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(5.0),
            backgroundColor: ColorManager.primary,
            minimumSize: Size(100.w, 20.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: Text(
          "No",
          style: getMFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      btnOkOnPress: btnOkOnPress,
    );
  }

  static getDashboardIcon({required IconButtonType iconButtonType}) {
    switch (iconButtonType) {
      case SchoolType():
        if (iconButtonType.nav == '0') {
          return ImageAssets.iconNotice;
        } else if (iconButtonType.nav == '1') {
          return ImageAssets.iconBulletin;
        } else if (iconButtonType.nav == '2') {
          return ImageAssets.iconActivities;
        } else if (iconButtonType.nav == '3') {
          return ImageAssets.locationSetting;
        }  else if (iconButtonType.nav == '4') {
          return ImageAssets.location;
        } else if (iconButtonType.nav == '5') {
          return ImageAssets.iconAttendance;
        } else {
          return ImageAssets.iconError;
        }
      case AcademicType():
        if (iconButtonType.nav == '0') {
          return ImageAssets.iconTimeTable;
        } else if (iconButtonType.nav == '1') {
          return ImageAssets.iconAttendance;
        } else if (iconButtonType.nav == '2') {
          return ImageAssets.iconSyllabus;
        } else if (iconButtonType.nav == '3') {
          return ImageAssets.iconAssignment;
        } else if (iconButtonType.nav == '4') {
          return ImageAssets.iconHomeWork;
        } else if (iconButtonType.nav == '5') {
          return ImageAssets.iconMark;
        } else if (iconButtonType.nav == '6') {
          return ImageAssets.iconClass;
        } else if (iconButtonType.nav == '7') {
          return ImageAssets.iconExam;
        } else if (iconButtonType.nav == '8') {
          return ImageAssets.iconMessage;
        } else {
          return ImageAssets.iconError;
        }
      default:
        return ImageAssets.iconError;
    }
  }

  static routeOnTap({required IconButtonType iconButtonType}) {
    switch (iconButtonType) {
      case SchoolType():
        if (iconButtonType.nav == '0') {
          Get.toNamed(RouteHelper.notice);
        } else if (iconButtonType.nav == '1') {
          Get.to(() => BulletinPage(),
              binding: BindingsBuilder.put(() => BulletinController()));
        } else if (iconButtonType.nav == '2') {
          Get.toNamed(RouteHelper.activity);
        } else if (iconButtonType.nav == '3') {
          Get.to(() => SaveLocation(),
              binding: BindingsBuilder.put(() => EmpAttendanceController()));
        } else if (iconButtonType.nav == '4') {
          Get.to(() => EmpAttendanceInfo(),
              binding: BindingsBuilder.put(() => EmpAttendanceController()));
        }else if (iconButtonType.nav == '5') {
          Get.to(() => EmpAttendance(),
              binding: BindingsBuilder.put(() => AttendanceController()));
        }
        break;
      case AcademicType():
        if (iconButtonType.nav == '0') {
          Get.to(() => ComingSoon());
        } else if (iconButtonType.nav == '1') {
          Get.to(() => Attendance(),
              binding: BindingsBuilder.put(() => AttendanceController()));
        } else if (iconButtonType.nav == '2') {
          Get.to(() => SyllabusList(),
              binding: BindingsBuilder.put(() => SyllabusController()));
        } else if (iconButtonType.nav == '3') {
          Get.to(() => AssignmentList(),
              binding: BindingsBuilder.put(() => AssignmentController()));
        } else if (iconButtonType.nav == '4') {
          Get.to(() => HomeWorkList(),
              binding: BindingsBuilder.put(() => HomeWorkController()));
        } else if (iconButtonType.nav == '5') {
          Get.to(() => MarkForm(),
              binding: BindingsBuilder.put(() => MarkController()));
        } else if (iconButtonType.nav == '6') {
          Get.to(() => OnlineClsList(),
              binding: BindingsBuilder.put(() => OnlineClsController()));
        } else if (iconButtonType.nav == '7') {
          Get.to(() => OnlineExamList(),binding: BindingsBuilder.put(()=>ExamController()));
        } else if (iconButtonType.nav == '8') {
          Get.to(() => MessagePage(),
              binding: BindingsBuilder.put(() => MessageController()));
        }
        break;
      default:
        return Get.off(() => SplashPage());
    }
  }

  static List<Color> cardTitleColor = [
    ColorManager.stateInfo,
    ColorManager.stateSuccess,
    ColorManager.stateDanger,
    ColorManager.grey
  ];

  static String getTodayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
