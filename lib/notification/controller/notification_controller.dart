import 'package:decora_admin/notification/model/notification_model.dart';
import 'package:decora_admin/notification/service/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notificationModel = NotificationModel(records: []).obs;
  var notificationService = Get.put(NotificationService());

  @override
  void onInit() async {
    notificationModel.value = await notificationService.getNotificationList();
    super.onInit();
  }
}
