import 'package:decora_admin/about/view/about.dart';
import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/attendance/view/emp_attendance.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/login/view/login.dart';
import 'package:decora_admin/online_exam/view/online_exam_list.dart';
import 'package:decora_admin/report/view/report.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../util/Ams.dart';
import '../../util/coming_soon.dart';
import '../../util/end_points.dart';

class CustomDrawer extends GetView<DashboardController> {
  CustomDrawer({super.key});



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: 288.w,
          height: double.infinity,
          color: ColorManager.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //header
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(color: ColorManager.primaryMedium))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Ams().imageWidget(
                              '${EndPoints.baseDownloadUrl}${controller.dashboardService.dashboardModel.value.profile?[0].emp_Photo??""}',
                              width: 50.w,
                              height: 50.h),

                          SizedBox(width: 16.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .dashboardService
                                    .dashboardModel
                                    .value
                                    .profile?[0]
                                    .emp_Name??"",
                                style: getRFStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.title2),
                              ),
                              SizedBox(height: 6.h),
                              Text(controller
                                  .dashboardService
                                  .dashboardModel
                                  .value
                                  .profile?[0]
                                  .emp_EmailID??"",
                                  style: getRFStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.body)),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: controller.toggleSidebar,
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: ColorManager.white,
                        ),
                      )
                    ],
                  ),
                ),

                _Menu(),
                Spacer(),
                InkWell(
                  onTap: (){
                    CommonService.saveAllVale();
                    Get.off(()=>LoginPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Row(
                          children: [
                            Icon(Icons.logout,size: 30.0, color: ColorManager.white,),
                            SizedBox(width: 60.w,),
                            Text(
                              "Logout",
                              style: getRFStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.title1),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Column _Menu() {
    return Column(
      children: [
        SizedBox(height: 20.h,),
        _menuItem(icon: Icons.home, label: "Home", fn: () {
          controller.toggleSidebar();
        }),
        _menuItem(icon: Icons.person, label: "Profile", fn: () {
          Get.toNamed(RouteHelper.profile);
        }),
        _menuItem(icon: Icons.school_outlined, label: "School Profile", fn: () {
          Get.toNamed(RouteHelper.schoolProfile);

        }),_menuItem(icon: Icons.lock_reset, label: "Change Pin", fn: () {
          Get.toNamed(RouteHelper.changePin);

        }),
        _menuItem(icon: Icons.important_devices, label: "Report", fn: () {
          //Get.to(() => ComingSoon());
          Get.to(() => Report());
        }),
        _menuItem(icon: Icons.info_outline, label: "About", fn: () {
          Get.to(()=>AboutUs());
        }),
        
        // _menuItem(icon: Icons.info_outline, label: "Teacher Attendance", fn: () {
        //   Get.to(()=>EmpAttendance(),binding: BindingsBuilder.put(()=>AttendanceController()));
        // }),
      ],
    );
  }

  Widget _menuItem(
      {required String label,
      required IconData icon,
      required void Function()? fn}) {
    return InkWell(
      onTap: fn,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorManager.white,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              label,
              style:
                  getRFStyle(color: ColorManager.white, fontSize: FontSize.s18),
            ),
          ],
        ),
      ),
    );
  }
}
