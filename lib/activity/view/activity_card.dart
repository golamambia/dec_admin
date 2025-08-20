import 'package:decora_admin/activity/controller/activity_controller.dart';
import 'package:decora_admin/activity/view/activity_update_page.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../model/activity_model.dart';

class ActivityCard extends GetView<ActivityController> {
  ActivityRecord activityRecord;
  int colorIndex;
  Function refresh;
  late final Rx<bool> _isActive = false.obs;

  ActivityCard(
      {super.key,
      required this.activityRecord,
      required this.colorIndex,
      required this.refresh}){
    _isActive.value = activityRecord.status == "True" ? true : false;

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
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
                    activityRecord.activityTitle ?? "",
                    textAlign: TextAlign.center,
                    style: getMFStyle(
                        color: ColorManager.white, fontSize: FontSize.title2),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  activityRecord.activityDetails ?? "",
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
                            activityRecord.activityDate ?? "",
                            style: getRFStyle(
                                color: ColorManager.greyDark,
                                fontSize: FontSize.body),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => Switch(
                        value: _isActive.value,
                        onChanged: (value) {
                          _isActive.value = value;
                          controller.onCardSwitchToggle(
                              status: _isActive.value,
                              activityRecord: activityRecord,
                              fn: refresh);
                        },
                      ),
                    )
                    /*
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Ams().imageWidget(ImageAssets.iconClock,
                            width: 20.w, height: 20.h),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "11:45 AM",
                          style: getRFStyle(
                              color: ColorManager.grayDark,
                              fontSize: FontSize.body),
                        )
                      ],
                    ),
                  ),
                    */
                  ],
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
                Text(
                  "${activityRecord.className}",
                  style: getRFStyle(
                      color: ColorManager.secondary,
                      fontSize: FontSize.body),
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),

               /* Text(
                  "Download File ->",
                  style: getRFStyle(
                      color: ColorManager.secondary, fontSize: FontSize.body),
                ),*/


                /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Download File ->",
                    style: getRFStyle(
                        color: ColorManager.secondary,
                        fontSize: FontSize.body),
                  ),
                  Ams().imageWidget(ImageAssets.iconDownloadFile,
                      width: 30.w, height: 30.h),
                ],
              ),
                    */
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
              controller.onDeleteItem(
                  activityId: activityRecord.activityID!, fn: refresh);
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
              Get.to(()=>ActivityUpdatePage(refresh: refresh, activityRecord: activityRecord));
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
