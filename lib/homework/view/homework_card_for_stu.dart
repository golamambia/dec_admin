import 'package:decora_admin/dashboard/controller/home_controller.dart';
import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:decora_admin/util/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class HomeworkCardForStu extends GetView<HomeController> {
  // const HomeworkCardForStu({super.key});

  late HomeWorkRecord homeWorkRecord;
  late var colorIndex;
  late var _isActive = true.obs;

  bool? activeSwitch;
  bool? activeView;

  HomeworkCardForStu(
      {super.key, required this.homeWorkRecord, required this.colorIndex, required this.activeView}) {
    // _isActive.value = homeWorkRecord. == "True" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                width: 320.w,
                decoration: BoxDecoration(
                    color: Ams.cardTitleColor[colorIndex],
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10.r))),
                child: Text(
                  homeWorkRecord.postMode ?? "",
                  textAlign: TextAlign.center,
                  style: getBFStyle(
                      color: ColorManager.white, fontSize: FontSize.title2),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "Note: ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    // textAlign: TextAlign.center,
                    style: getMFStyle(
                        color: ColorManager.blue, fontSize: FontSize.s14,),
                  ),Text(
                    homeWorkRecord.note ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    // textAlign: TextAlign.center,
                    style: getRFStyle(
                        color: ColorManager.grey, fontSize: FontSize.s14),
                  ),
                ],
              ),
              Divider(
                color: ColorManager.greyDark,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Ams().imageWidget(ImageAssets.iconCalender,
                            width: 20.w, height: 20.h),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          homeWorkRecord.uploadDate ?? "",
                          style: getRFStyle(
                              color: ColorManager.greyDark,
                              fontSize: FontSize.body),
                        )
                      ],
                    ),
                  ),
                  Text("Adm : ${homeWorkRecord.admnNo}",style: getMFStyle(color: ColorManager.orange, fontSize: FontSize.s14),)
                ],
              ),
              Divider(
                color: ColorManager.greyDark,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Student: ${homeWorkRecord.sT_Name}",style: getMFStyle(color: ColorManager.green, fontSize: FontSize.s14),),

                  Text(
                    "${homeWorkRecord.className}",
                    style: getRFStyle(
                        color: ColorManager.green, fontSize: FontSize.body),
                  ),
                ],
              ),
              Divider(
                color: ColorManager.greyDark,
              ),
              Row(
                mainAxisAlignment: homeWorkRecord.filePath != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Teacher: ${homeWorkRecord.empName}",style: getMFStyle(color: ColorManager.primary, fontSize: FontSize.s14),),
                  InkWell(
                    onTap: () {
                      if (homeWorkRecord.filePath == null ||
                          homeWorkRecord.filePath == '') return;
                      FileUtils().downloadFiles(EndPoints.baseDownloadUrl +
                          homeWorkRecord.filePath!);
                    },
                    child: homeWorkRecord.filePath != null
                        ? Ams().imageWidget(ImageAssets.iconDownloadFile,
                            width: 30.w, height: 30.h)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
