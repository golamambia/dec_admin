import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../util/end_points.dart';
import '../controller/emp_attendance_controller.dart';

class AutoEmpAttendance extends GetView<EmpAttendanceController> {
  AutoEmpAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    controller.service.getTodayEmpAttendanceInfo();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: controller.service.todayEmpAttendance.stream,
            builder: (context, sn) {
              if (sn.data == null)
                return Center(
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.person_add),
                      onPressed: () {
                        controller.takeAutoAttendance();
                      },
                      label: Text("Auto Attend.")),
                );
              // var data=sn!.data.
              return Column(
                children: [
                  Text("Attendance Taken successfully"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: ColorManager.primary, thickness: 2,),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: ListTile(
                        leading: Ams().imageWidget(
                            '${EndPoints.baseDownloadUrl + controller.dashboardService.dashboardModel.value.profile![0].emp_Photo!}',
                            width: 60.w,
                            height: 60.h),
                        title: Text(sn.data!.records?.first.emp_Name ?? ""),
                        subtitle: Text(sn.data?.records?.first.emp_Code ?? ""),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
