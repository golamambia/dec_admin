/*
import 'package:decora_admin/util/Ams.dart';
import 'package:geofence_foreground_service/constants/geofence_event_type.dart';
import 'package:geofence_foreground_service/exports.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';
import 'package:geofence_foreground_service/models/zone.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Top-level callback method for geofencing
@pragma('vm:entry-point')
void callbackDispatcher() async {
  Get.log("Callback initiated.");

  GeofenceForegroundService().handleTrigger(
    backgroundTriggerHandler: (zoneID, triggerType) {
      Get.log("Zone ID: $zoneID");

      switch (triggerType) {
        case GeofenceEventType.enter:
          Get.log('Entered the zone.');
          break;
        case GeofenceEventType.exit:
          Get.log('Exited the zone.');
          break;
        case GeofenceEventType.dwell:
          Get.log('Dwelling in the zone.');
          break;
          case GeofenceEventType.unKnown:
          Get.log('Unknown in the zone.');
          break;
        default:
          Get.log('Unknown geofence event type.');
          break;
      }

      return Future.value(true);
    },
  );
}

class GeofencingController extends GetxController {
  final List<LatLng> timesSquarePolygon = [
    // const LatLng(Angle.degree(40.758078), Angle.degree(-73.985640)),
    // const LatLng(Angle.degree(40.757983), Angle.degree(-73.985417)),
    // const LatLng(Angle.degree(40.757881), Angle.degree(-73.985493)),
    // const LatLng(Angle.degree(40.757956), Angle.degree(-73.985688)),
    const LatLng(Angle.degree(22.852621), Angle.degree(88.410244)),
    const LatLng(Angle.degree(22.852668), Angle.degree(88.410163)),
    const LatLng(Angle.degree(22.852793), Angle.degree(88.410237)),
    const LatLng(Angle.degree(22.852745), Angle.degree(88.410324)),
  ];

  @override
  void onInit() {
    super.onInit();
    Get.log("GeofencingController initialized.");
    // Position position = await Geolocator.getCurrentPosition();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Get.log("Checking location permissions.");

    await _requestLocationPermission();

    final hasServiceStarted =
        await GeofenceForegroundService().startGeofencingService(
      contentTitle: 'Geofencing Service Running',
      contentText: 'Background geofencing is active for monitoring zones.',
      notificationChannelId: 'com.app.geofencing_notifications_channel',
      serviceId: 525600,
      callbackDispatcher: callbackDispatcher,
    );

    if (hasServiceStarted) {
      Get.log("Geofencing service started successfully.");
      await GeofenceForegroundService().addGeofenceZone(
        zone: Zone(
          id: 'zone#1_id',
          radius: 250,
          coordinates: timesSquarePolygon,
        ),
      );
    } else {
      Get.log("Failed to start geofencing service.");
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    final loactionAlways = await Permission.locationAlways.request();

    if (status.isGranted && loactionAlways.isGranted) {
      // Ams.ft("Location permission granted.");
    } else if (status.isDenied && loactionAlways.isDenied) {
      Ams.ft("Location permission is required for attendance tracking.");
    } else if (status.isPermanentlyDenied &&
        loactionAlways.isPermanentlyDenied) {
      Get.log("Location permission permanently denied. Opening app settings.");
      openAppSettings();
    } else {
      Get.log("Location permission status: $status");
    }
  }

  @override
  void onClose() {
    GeofenceForegroundService().startGeofencingService(
        notificationChannelId: "com.app.geofencing_notifications_channel",
        contentTitle: "Geofencing Service Running Stop",
        contentText: 'Background geofencing is de-active for monitoring zones.',
        callbackDispatcher: callbackDispatcher);
    super.onClose();
  }
}
*/
