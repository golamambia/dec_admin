import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/push_notification_service.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/splash/SplashPage.dart';
import 'package:decora_admin/util/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

// Import the generated file
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.notification?.title}");
  print("Handling a background message: ${message.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AttendanceController());
  await initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initialize firebaseMessage
  //await PushNotificationService.init();
  //initialize firebase local notification
  await PushNotificationService.localNotiInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Get.log("onMessageApp");
  },);

  final RemoteMessage? message= await FirebaseMessaging.instance.getInitialMessage();
  if(message!=null){
    Future.delayed(Duration(seconds: 1),() {
      Get.log("opening from terminated state");
      PushNotificationService.showSimpleNotification(
                    title: message.notification?.title ?? "",
                    body: message.notification?.body ?? "",
                    payload: "");
      Get.off(RouteHelper.dashboard);
    },);
  }
  // FirebaseMessaging.instance.getInitialMessage().then(
  //   (value) {
  //     if (value != null){
  //       PushNotificationService.showSimpleNotification(
  //           title: value.notification?.title ?? "",
  //           body: value.notification?.body ?? "",
  //           payload: "");
  //     }
  //
  //   },
  // );

  FirebaseMessaging.onMessage.listen(
    (event) {
      Get.log("onMessage");
      PushNotificationService.showSimpleNotification(
          title: event.notification?.title ?? "",
          body: event.notification?.body ?? "",
          payload: "");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Decora School',
          theme: ThemeData(
              primaryColor: ColorManager.primary,
              // primarySwatch: ColorManager.primary,
              textTheme: Typography.englishLike2018.apply(
                  fontSizeFactor: 1.sp,
                  displayColor: Colors.black,
                  bodyColor: Colors.black),
              fontFamily: FontConstants.fontFamily,
              useMaterial3: false,
              colorScheme: ThemeData()
                  .colorScheme
                  .copyWith(primary: ColorManager.primary)),

          home: child,
          // initialRoute: RouteHelper.splash,
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          builder: EasyLoading.init(),
        );
      },
      child: SplashPage(),
    );
  }
}
