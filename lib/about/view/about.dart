import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';
import '../../../util/ams.dart';
import '../../resource/assets_manger.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "About",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
/*
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Icon(
                Icons.notifications,
                color: ColorManager.white,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
*/
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ams().imageWidget(ImageAssets.logo, height: 100.h, width: 174.w),
            SizedBox(
              height: 26.h,
            ),
            Text(
              "“Net Custodian App”",
              style:
                  getMFStyle(color: ColorManager.black, fontSize: FontSize.s20),
            ).center(),
            SizedBox(
              height: 10.h,
            ),
            Text(
              """means Online Caretaker. This complete concept is designed to contribute in keeping track of the students’ every move and to provide a direct communication platform between students and school Management.""",
              textAlign: TextAlign.center,
              style:
                  getRFStyle(color: ColorManager.grey, fontSize: FontSize.s16),
            ).center(),
            const Spacer(),
            Ams().imageWidget(ImageAssets.logo, height: 97.h, width: 76.w),
            Text(
              "Decora Infotech Pvt. Ltd.",
              style:
                  getRFStyle(color: ColorManager.grey, fontSize: FontSize.s18),
            ),
            Text(
              "www.decorainfotech.in",
              style:
                  getRFStyle(color: ColorManager.grey, fontSize: FontSize.s16),
            ),
          ],
        ),
      ),
    );
  }
}
