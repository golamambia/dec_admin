import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/fee_controller.dart';
import '../model/fee_model.dart';

class FeeCard extends GetView<FeeController> {
  // const FeeCardCard({super.key});

  late FeeRecord feeRecord;
  late var colorIndex;
  late var _isActive = true.obs;

  FeeCard({super.key, required this.feeRecord, required this.colorIndex}) {
    // _isActive.value = feeRecord. == "True" ? true : false;
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
                  feeRecord.sT_Name ?? "",
                  textAlign: TextAlign.center,
                  style: getBFStyle(
                      color: ColorManager.white, fontSize: FontSize.title2),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildTextRow(label: "Admission ", value: feeRecord.admnNo ?? ""),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Text(
                    "Father : ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    // textAlign: TextAlign.center,
                    style: getMFStyle(
                        color: ColorManager.greyDark, fontSize: FontSize.body),
                  ),
                  Text(
                    "${feeRecord.guardianName ?? ""}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    // textAlign: TextAlign.center,
                    style: getRFStyle(
                        color: ColorManager.greyDark, fontSize: FontSize.body),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              _buildTextRow(
                  label: "Phone No.", value: feeRecord.guardianMobile ?? ""),
              SizedBox(
                height: 10.h,
              ),
/*
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
                          feeRecord.className??"",
                          style: getRFStyle(
                              color: ColorManager.grayDark,
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
                          "11:45 AM",
                          style: getRFStyle(
                              color: ColorManager.grayDark,
                              fontSize: FontSize.body),
                        )
                      ],
                    ),
                  ),
                ],
              ),
*/
              Divider(
                color: ColorManager.greyDark,
              ),
              _buildTextRow(
                  label: "Fee",
                  value: feeRecord.fee ?? "",
                  color: Colors.amber),
              Divider(
                color: ColorManager.greyDark,
              ),
              _buildTextRow(
                  label: "Fine",
                  value: feeRecord.fine ?? "",
                  color: Colors.red),
              Divider(
                color: ColorManager.greyDark,
              ),
              _buildTextRow(
                  label: "Amount",
                  value: feeRecord.amt ?? "",
                  color: Colors.green),
/*              Divider(
                color: ColorManager.grayDark,
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
                      "${feeRecord.fee}",
                      style: getRFStyle(
                          color: ColorManager.grayDark,
                          fontSize: FontSize.body),
                    )
                  ],
                ),
              ),*/
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTextRow(
      {required String label, required String value, Color? color}) {
    return Row(
      children: [
        Text(
          "${label} : ",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // textAlign: TextAlign.center,
          style: getMFStyle(
              color: color ?? ColorManager.greyDark, fontSize: FontSize.body),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // textAlign: TextAlign.center,
          style:
              getRFStyle(color: ColorManager.greyDark, fontSize: FontSize.body),
        ),
      ],
    );
  }
}
