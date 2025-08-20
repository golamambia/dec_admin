import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resource/color_manager.dart';
import '../../../../resource/font_manager.dart';
import '../../../../resource/styles_manager.dart';

class SchoolProfile extends GetView<DashboardController> {
  SchoolProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "School Profile",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              controller.dashboardService.dashboardModel.value.schoolProfile?.first.branchName??"",
              style:
                  getMFStyle(color: ColorManager.black, fontSize: FontSize.s15),
            ),
            SizedBox(
              height: 21.h,
            ),
            appTile(
                icon: Icons.call,
                color: ColorManager.primaryLight,
                containerColor: ColorManager.primary,
                title: "Contact Number",
                subtitle: "${controller.dashboardService.dashboardModel.value.schoolProfile?.first.contactNo}"),
            SizedBox(
              height: 20.h,
            ),
            appTile(
                icon: Icons.email,
                color: const Color(0xffFFF9F0),
                containerColor: ColorManager.stateInfo,
                title: "Email",
                subtitle: "${controller.dashboardService.dashboardModel.value.schoolProfile?.first.emailID}"),
            SizedBox(
              height: 20.h,
            ),
            appTile(
                icon: Icons.language_outlined,
                color: ColorManager.primaryLight,
                containerColor: ColorManager.primary,
                title: "Website",
                subtitle: "${controller.dashboardService.dashboardModel.value.schoolProfile?.first.website}"),
            SizedBox(
              height: 20.h,
            ),
            appTile(
                icon: Icons.location_on_outlined,
                color: const Color(0xffFFF9F0),
                containerColor: ColorManager.stateInfo,
                title: "Address",
                subtitle: "${controller.dashboardService.dashboardModel.value.schoolProfile?.first.branchAddress}"),
                    // "{Ams.schoolProfile.scHADDRESSLINE1} {Ams.schoolProfile.scHADDRESSLINE2} {Ams.schoolProfile.scHADDRESSLINE3}"),
          ],
        ),
      ),
    );
  }

  Widget appTile(
          {required IconData? icon,
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
                    colorFilter: ColorFilter.mode(containerColor, BlendMode.srcIn),
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
