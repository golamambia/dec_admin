import 'package:decora_admin/notice/controller/notice_controller.dart';
import 'package:decora_admin/notice/model/notice_model.dart';
import 'package:decora_admin/notice/view/notice_update_page.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popover/popover.dart';

import '../../notice/model/notice_model.dart';
import '../../util/end_points.dart';
import '../../util/file_utils.dart';

class NoticeCard extends GetView<NoticeController> {
  NoticeRecord noticeRecord;
  int colorIndex;
  Function refresh;

  late final Rx<bool> _isActive = false.obs;

  NoticeCard(
      {super.key,
      required this.noticeRecord,
      required this.colorIndex,
      required this.refresh}) {
    _isActive.value = noticeRecord.status == "True" ? true : false;
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
                    noticeRecord.noticeTitle ?? "",
                    textAlign: TextAlign.center,
                    style: getBFStyle(
                        color: ColorManager.white, fontSize: FontSize.title2),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  noticeRecord.noticeDetails ?? "",
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
                            noticeRecord.noticeDate ?? "",
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
                              status: value, noticeRecord: noticeRecord);
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
                  "${noticeRecord.className}",
                  style: getRFStyle(
                      color: ColorManager.secondary, fontSize: FontSize.body),
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
                noticeRecord.filePath!.isNotEmpty?Row(
          mainAxisAlignment: noticeRecord.filePath != null ||
              noticeRecord.filePath != ""
              ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
          "Download File ->",
              style: getRFStyle(
              color: ColorManager.secondary,
              fontSize: FontSize.body),
        ),
        noticeRecord.filePath != null || noticeRecord.filePath != ""
            ? InkWell(
          onTap: () {
            if (noticeRecord.filePath == null ||
                noticeRecord.filePath == '') return;
            FileUtils().downloadFiles(
                EndPoints.baseDownloadUrl +
                    noticeRecord.filePath!);
          },
          child: Ams().imageWidget(
              ImageAssets.iconDownloadFile,
              width: 30.w,
              height: 30.h),
        )
            : const SizedBox.shrink(),
        ],
      ):SizedBox.shrink(),
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
                  noticeId: noticeRecord.noticeID!, fn: refresh);
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
              Get.to(() => NoticeUpdatePage(
                  refresh: refresh, noticeRecord: noticeRecord));
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
