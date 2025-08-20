import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/emp_attendance_controller.dart';
class EmpAttendance extends GetView<EmpAttendanceController> {
  EmpAttendance({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    controller.service.getEmpAttendanceInfo();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: controller.service.map.stream,
            builder: (context, sn) {
              if (sn.data == null || sn.data!.isEmpty) return Text("Please Wait...");
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attendance Summary",
                              style: getBFStyle(color: Colors.white, fontSize: FontSize.s18),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Total",
                              style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.service.totalEmpAttendance.value.setting?.first.total}",
                                  style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                              width: double.infinity,
                              child: Divider(
                                thickness: 2,
                                color: ColorManager.white,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Day Attended",
                                      style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                                    ),
                                    Text(
                                      "${controller.service.totalEmpAttendance.value.setting?.first.present}",
                                      style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 30.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Day Absent",
                                      style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                                    ),
                                    Text(
                                      "${controller.service.totalEmpAttendance.value.setting?.first.absent}",
                                      style: getMFStyle(color: Colors.white, fontSize: FontSize.s16),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    HeatMapCalendar(
                      initDate: DateTime.now(),
                      flexible: true,
                      fontSize: 14,
                      datasets: sn.data!,
                      colorMode: ColorMode.color,
                      showColorTip: false,
                      textColor: ColorManager.black,
                      weekTextColor: ColorManager.black,
                      weekFontSize: 14,
                      monthFontSize: 18,
                      colorsets: {
                        1: ColorManager.green,
                        2: ColorManager.red,
                        3: ColorManager.orange,
                        4: ColorManager.blue
                      },
                      onMonthChange: (p0) {
                        print("Date change : ${p0.toString()}");
                      },
                      onClick: (value) {
                        // Handle click event here
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 10.h),
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: ColorManager.green, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Present",
                            style: getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: ColorManager.red, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Absent",
                            style: getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: ColorManager.orange, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Leave",
                            style: getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: ColorManager.blue, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "N/A",
                            style: getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
