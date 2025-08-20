import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:decora_admin/homework/controller/home_work_controller.dart';
import 'package:decora_admin/homework/model/home_work_model.dart';
import 'package:decora_admin/homework/view/home_work_update_page.dart';
import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/view/exam_cls.dart';
import 'package:decora_admin/online_exam/view/exam_update_page.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:decora_admin/util/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popover/popover.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../../util/date_utils.dart';

class ExamCard extends GetView<ExamController> {
  // const ExamCard({super.key});

  late ExamRecords examRecord;
  late var colorIndex;
  late var _isActive = true.obs;
  bool activeView;

  ExamCard(
      {super.key,
      required this.examRecord,
      required this.colorIndex,
      required this.activeView}) {
    // _isActive.value = examRecord. == "True" ? true : false;
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
                    examRecord.exam ?? "",
                    textAlign: TextAlign.center,
                    style: getBFStyle(
                        color: ColorManager.white, fontSize: FontSize.title2),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                RichText(text: TextSpan(
                    children:[
                      TextSpan(text: "From Date: ",style: getBFStyle(color: blackColor, fontSize: FontSize.s14)),
                      TextSpan(text: CustomDateUtils.formatDateWithMonth(examRecord.examDateFrom??""),style: getRFStyle(color: blackColor, fontSize: FontSize.s14)),
                    ]
                )) ,
                SizedBox(
                  height: 10.h,
                ),
                RichText(text: TextSpan(
                  children:[
                    TextSpan(text: "To Date: ",style: getBFStyle(color: blackColor, fontSize: FontSize.s14)),
                    TextSpan(text: CustomDateUtils.formatDateWithMonth(examRecord.examDateTo??""),style: getRFStyle(color: blackColor, fontSize: FontSize.s14)),
                  ]
                )) ,
                Divider(
                  color: ColorManager.greyDark,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // controller.onViewClick(examRecord);
                        controller.examId.value=examRecord.examID??"";
                        Get.to(()=>ExamCls());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text(
                            "View Class",
                            style: getRFStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.body),
                          ),
                        ),
                      ),
                    ),
/*
                    Switch(value: examRecord.isActive=="True"?true:false, onChanged: (value) {},)
*/
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
            onTap: () async {
              Navigator.of(context)..pop();
              await controller.examService.deleteExam(examId: examRecord.examID??"");
              controller.fetchExam();

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
              controller.setExamForm(examRecord);
              Get.to(() => ExamUpdatePage());
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
