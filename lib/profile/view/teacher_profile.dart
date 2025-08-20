import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:flutter/material.dart'hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../resource/color_manager.dart';
import '../../../../resource/font_manager.dart';
import '../../../../resource/styles_manager.dart';
import '../../../../util/ams.dart';
import 'package:decora_admin/resource/assets_manger.dart';


class TeacherProfile extends GetView<DashboardController> {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white, onPressed: () => Get.back(),),

        backgroundColor: ColorManager.primary,
        title: Text("Profile", style: getRFStyle(
            color: ColorManager.white, fontSize: FontSize.s14),),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Ams().imageWidget(
                      '${EndPoints.baseDownloadUrl+controller.dashboardService.dashboardModel.value.profile![0].emp_Photo!}',
                       width: 80.h, height: 80.h),
                  SizedBox(width: 18.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${controller.dashboardService.dashboardModel.value.profile?.first.emp_Name} ${controller.dashboardService.dashboardModel.value.profile?.first.emp_Title}",
                        style: getRFStyle(color: ColorManager.white,
                            fontSize: FontSize.s12),),
                      SizedBox(height: 10.h,),
                      Text("Subject: ${controller.dashboardService.dashboardModel.value.profile?.first.subjectExpertise}", style: getMFStyle(
                          color: ColorManager.white, fontSize: FontSize.s10),),
                      SizedBox(height: 10.h,),
                      Text("Attendance", style: getRFStyle(
                          color: ColorManager.white, fontSize: FontSize.s10),),
                      SizedBox(height: 5.h,),

                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        percent: 0.95,
                        progressColor: Colors.black,
                        width: 207.w,
                      ),

                      // SizedBox(height: 10.h,),
                      // Text("Fee",style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s10),),
                      // SizedBox(height: 5.h,),
                      //
                      // LinearPercentIndicator(
                      //   padding: EdgeInsets.zero,
                      //   percent: 0.75,
                      //   progressColor: Colors.black,
                      //   width: 207.w,
                      // ),
                    ],
                  ),
                ],
              ),
            ),


            SizedBox(height: 25.h,),
            Text("Personal Information", style: getMFStyle(
                color: ColorManager.black, fontSize: FontSize.s16),),
            SizedBox(height: 25.h,),


            appTile(icon: Icons.confirmation_num,
                color: ColorManager.primaryLight,
                containerColor: ColorManager.primary,
                title: "Date of joining",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.emp_DOJ}"),

            SizedBox(height: 20.h,),
            appTile(icon: Icons.cake,
                color: const Color(0xffFFF9F0),
                containerColor: ColorManager.stateInfo,
                title: "Date of birth",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.emp_DOB}"),

            SizedBox(height: 20.h,),
            appTile(icon: Icons.emoji_people_outlined,
                color: ColorManager.primaryLight,
                containerColor: ColorManager.primary,
                title: "Date of anniversary",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.doAnniversary}"),

            SizedBox(height: 20.h,),
            appTile(icon: Icons.woman_outlined,
                color: const Color(0xffFFF9F0),
                containerColor: ColorManager.stateInfo,
                title: "Gender",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.emp_Gender}"),

            SizedBox(height: 20.h,),
            appTile(icon: Icons.perm_contact_calendar_outlined,
                color: ColorManager.primaryLight,
                containerColor: ColorManager.primary,
                title: "Contact Number",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.emp_MobileNo}\n${controller.dashboardService.dashboardModel.value.profile?.first.emp_AlternateNo}"),

            SizedBox(height: 20.h,),
            appTile(icon: Icons.location_on_outlined,
                color: const Color(0xffFFF9F0),
                containerColor: ColorManager.stateInfo,
                title: "Address",
                subtitle: "${controller.dashboardService.dashboardModel.value.profile?.first.emp_CurrentAddress}"),
          ],
        ),
      ),
    );
  }

  Widget appTile({required IconData? icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color containerColor
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                offset: Offset(0, 1),
                blurRadius: 4)
          ],
        ),
        child: ListTile(
          leading: Stack(
              alignment: Alignment.center,
              children: [
                // Ams().imageWidget(ImageAssets.iconContainer),
                SvgPicture.asset(
                    width: 65.w,
                    ImageAssets.iconContainerSVG,
                    colorFilter: ColorFilter.mode(
                        containerColor, BlendMode.srcIn),
                    semanticsLabel: 'A red up arrow'
                ),
                Icon(
                  icon,
                  color: ColorManager.black,
                  size: 30.h,
                ),
              ]),
          title: Text(
            title,
            style:
            getMFStyle(color: ColorManager.black, fontSize: FontSize.s12),
          ),
          subtitle: Text(
            subtitle,
            style:
            getRFStyle(color: ColorManager.black, fontSize: FontSize.s12),
          ),
        ),
      );
}
