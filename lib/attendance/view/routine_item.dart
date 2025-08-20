import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


import '../../../../resource/color_manager.dart';
import '../../../../resource/font_manager.dart';
import '../../../../resource/styles_manager.dart';
import '../model/periods_model.dart';

class RoutineItem extends GetView<AttendanceController> {
  RoutineItem(
      {Key? key,
      required this.statusModel,
      required this.dayCode,
      required this.tID})
      : super(key: key);
  var isActive = false.obs;
  ObjPeriodStatusModel statusModel;
  String dayCode;
  String tID;

  @override
  Widget build(BuildContext context) {
    isActive.value=statusModel.status=="1"?true:false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "P${statusModel.period}  : ",
          style: getBFStyle(color: ColorManager.black, fontSize: FontSize.s13),
        ),
        SizedBox(
          height: 25,
          child: Obx(() => Switch(
              activeColor: Colors.white,
              inactiveTrackColor: ColorManager.orange,
              activeTrackColor: ColorManager.green,
              value: isActive.value,
              onChanged: (value) async {
                isActive.value=value;
               await controller.updatePeriod(statusModel.period,value);
              })),
        )
      ],
    );
  }
}
