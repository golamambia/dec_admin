import 'package:decora_admin/homework/controller/home_work_controller.dart';
import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/homework/view/home_work_update_page.dart';
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

class HomeWorkCard extends GetView<HomeWorkController> {
  // const HomeWorkCard({super.key});

  late HomeWorkRecord homeWorkRecord;
  late var colorIndex;
  late var _isActive = true.obs;
  bool activeView;

  HomeWorkCard(
      {super.key,
      required this.homeWorkRecord,
      required this.colorIndex,
      required this.activeView}) {
    // _isActive.value = homeWorkRecord. == "True" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => _popMenu(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.top,
          width: 250.w,
          height: 150.h,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: Padding(
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
                Text(
                  homeWorkRecord.postData ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  // textAlign: TextAlign.center,
                  style: getRFStyle(
                      color: ColorManager.greyDark, fontSize: FontSize.body),
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
                    /*Obx(
                      () => Switch(
                        value: _isActive.value,
                        onChanged: (value) {
                          _isActive.value = value;
                          // controller.onCardSwitchToggle(
                          //     status: _isActive.value,
                          //     fn: refresh, homeWorkRecord: homeWorkRecord);
                        },
                      ),
                    )*/
                  ],
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
                Text(
                  "${homeWorkRecord.className}",
                  style: getRFStyle(
                      color: ColorManager.secondary, fontSize: FontSize.body),
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
                    activeView == true
                        ? InkWell(
                            onTap: () {
                              controller.onViewClick(homeWorkRecord);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(
                                  "View",
                                  style: getRFStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.body),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
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
      ),
    );
  }

  Padding _popMenu() {
    var context = Get.context!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)..pop();
              controller.onDeleteItem(homeWorkId: homeWorkRecord.homeworkID!);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Delete',
                      style: getMFStyle(
                          color: ColorManager.white, fontSize: FontSize.title2),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context)..pop();
              controller.setFormValue(homeworkRecord: homeWorkRecord);
              Get.to(() => HomeWorkUpdatePage());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Edit',
                      style: getMFStyle(
                          color: ColorManager.white, fontSize: FontSize.title2),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
