import 'package:decora_admin/activity/controller/activity_controller.dart';
import 'package:decora_admin/activity/view/activity_page.dart';
import 'package:decora_admin/activity/view/activity_update_page.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/dashboard/view/dashboard.dart';
import 'package:decora_admin/dashboard/view/home.dart';
import 'package:decora_admin/fee/service/fee_service.dart';
import 'package:decora_admin/localPin/view/change_local_pin.dart';
import 'package:decora_admin/localPin/view/local_pin.dart';
import 'package:decora_admin/login/view/login.dart';
import 'package:decora_admin/notice/view/notice_add_page.dart';
import 'package:decora_admin/notice/view/notice_page.dart';
import 'package:decora_admin/profile/view/school_profile.dart';
import 'package:decora_admin/profile/view/teacher_profile.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String notice = '/notice';
  static const String activity = '/activity';
  static const String pin = '/pin';
  static const String profile = '/profile';
  static const String schoolProfile = '/schoolProfile';
  static const String changePin = '/changePin';


  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: pin, page: () => LocalPin()),
    GetPage(name: schoolProfile, page: () => SchoolProfile()),
    GetPage(name: changePin, page: () => ChangePin()),
    GetPage(name: home, page: () => Home(),binding: DashboardBinding()),
    GetPage(name: dashboard, page: () => Dashboard(),binding: DashboardBinding()),
    GetPage(name: notice, page: () =>  NoticePage(), transition: Transition.zoom),
    GetPage(name: activity, page: () => ActivityPage(), transition: Transition.zoom, binding: ActivityBinding()),
    GetPage(name: profile, page: () => const TeacherProfile(),binding: DashboardBinding()),
  ];
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(FeeService());
  }
}

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActivityController());
  }
}
