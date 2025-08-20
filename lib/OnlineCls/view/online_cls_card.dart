import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/online_cls_controller.dart';
import '../model/online_cls_model.dart';
import 'online_cls_update_page.dart';

class OnlineClsCard extends GetView<OnlineClsController> {
  // const OnlineClsCard({super.key});

  late OnlineClsRecord onlineClsRecord;
  late var colorIndex;
  late var _isActive = true.obs;

  OnlineClsCard(
      {super.key, required this.onlineClsRecord, required this.colorIndex}) {
    _isActive.value = onlineClsRecord.status == "True" ? true : false;
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
                    onlineClsRecord.title ?? "",
                    textAlign: TextAlign.center,
                    style: getBFStyle(
                        color: ColorManager.white, fontSize: FontSize.title2),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  onlineClsRecord.classLink ?? "",
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
                            onlineClsRecord.classDate ?? "",
                            style: getRFStyle(
                                color: ColorManager.greyDark,
                                fontSize: FontSize.body),
                          )
                        ],
                      ),
                    ),
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
                            onlineClsRecord.classTime ?? "",
                            style: getRFStyle(
                                color: ColorManager.greyDark,
                                fontSize: FontSize.body),
                          )
                        ],
                      ),
                    ),
/*
                    Obx(
                      () => Switch(
                        value: _isActive.value,
                        onChanged: (value) {
                          _isActive.value = value;
                          controller.onCardSwitchToggle(
                              status: _isActive.value,
                              onlineClsRecord: onlineClsRecord);
                        },
                      ),
                    )*/
                  ],
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
                Text(
                  onlineClsRecord.className ?? "",
                  textAlign: TextAlign.center,
                  style: getBFStyle(
                      color: ColorManager.green, fontSize: FontSize.title2),
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Clipboard.setData(new ClipboardData(text: onlineClsRecord.classLink!));
                        Ams.ft("copied");
                        Get.log(onlineClsRecord.classLink??"");
                        var uri = Uri.parse(onlineClsRecord.classLink.toString());
                        if(onlineClsRecord.classLink==null||onlineClsRecord.classLink!.isEmpty){
                          Ams.ft("No link for launch");
                          return;
                        }
                        launchUrl(uri);
                      },
                      child: Text(
                        "Click to copy link",
                        style: getRFStyle(
                            color: ColorManager.secondary,
                            fontSize: FontSize.body),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     if(onlineClsRecord.filePath==null||onlineClsRecord.filePath=='') return;
                    //     FileUtils().downloadFiles(EndPoints.baseDownloadUrl+onlineClsRecord.filePath!);
                    //   },
                    //   child: onlineClsRecord.filePath!=null?Ams().imageWidget(ImageAssets.iconDownloadFile,
                    //       width: 30.w, height: 30.h):const SizedBox.shrink(),
                    // ),
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
              controller.onDeleteItem(
                  onlineClsId: onlineClsRecord.onlineClassID!);
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
              controller.setFormValue(onlineClsRecord: onlineClsRecord);
              Get.to(() => OnlineClsUpdatePage());
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
