import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class Attendance extends GetView<AttendanceController> {
  const Attendance({super.key});

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
          "Attendance",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            // onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Student', 'Teacher'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: SingleSelectCls(
                          clsId: controller.clsId,
                          label: "Select Class",
                          clsCallBack: controller.clsCallback)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: BuildDateTextFormField(
                          controller: controller.currentDate,
                          label: "Select Date",
                          callBack: controller.dateCallBack)),
                ],
              ),
            ),
            Row(
              children: [
                _buildRadio(
                    label: "Present",
                    activeColor: ColorManager.green,
                    value: 1,
                    currentVal: controller.radioOption),
                _buildRadio(
                  label: "Absent",
                  activeColor: ColorManager.red,
                  value:2,
                  currentVal: controller.radioOption,
                ),
                _buildRadio(
                  label: "Leave",
                  activeColor: ColorManager.orange,
                  value: 3,
                  currentVal: controller.radioOption,
                ),
                _buildRadio(
                  label: "NA",
                  activeColor: ColorManager.blue,
                  value: 4,
                  currentVal: controller.radioOption,
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: ColorManager.primary),
                child: Text(
                  "Student Attendance",
                  textAlign: TextAlign.center,
                  style: getMFStyle(
                      color: ColorManager.white, fontSize: FontSize.s18),
                ),
              ),
            ),
            //TODO:Make this dynamic
            // _buildAttendanceCard(
            //     name: "Raju Shaw",
            //     fatherName: "S K Narayan Shaw",
            //     typeId: 1.obs),

            StreamBuilder(
              stream: controller.attendanceModel.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null ||
                    snapshot.data!.records == null ||
                    snapshot.data!.records!.isEmpty) {
                  return SizedBox(height:100.h,child: Center(child: Text("Please select class and Date")));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.records?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    var data = snapshot.data!.records![i];
                    return _buildAttendanceCard(
                        // backColor: i % 2 == 0
                        //     ? ColorManager.white
                        //     : ColorManager.primaryLight,
                        name: data.sT_Name ?? "",
                        fatherName: data.guardianName ?? "",
                        roll: data.rolL_No ?? "",
                        typeId: data.attenadanceMode??0.obs);
                  },
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.onDeleteStudent();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4.0),
                      backgroundColor: ColorManager.red,
                      minimumSize: Size(80.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Delete",
                    style: getMFStyle(
                        color: ColorManager.white, fontSize: FontSize.s14),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4.0),
                      backgroundColor: ColorManager.blue,
                      minimumSize: Size(80.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Cancel",
                    style: getMFStyle(
                        color: ColorManager.white, fontSize: FontSize.s14),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.isSMS=0;
                    controller.onSave();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4.0),
                      backgroundColor: ColorManager.green,
                      minimumSize: Size(80.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Save",
                    style: getMFStyle(
                        color: ColorManager.white, fontSize: FontSize.s14),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),

                ElevatedButton(
                  onPressed: () {
                    controller.isSMS=1;
                    controller.onSave();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4.0),
                      backgroundColor: ColorManager.primary,
                      minimumSize: Size(80.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Save & Send",
                    style: getMFStyle(
                        color: ColorManager.white, fontSize: FontSize.s14),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard({
    // required Color backColor,
    required String name,
    required String fatherName,
    required String roll,
    required Rx<int> typeId,
  }) {


    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(
              width: 1,
              color: typeId.value == 1
                  ? ColorManager.green
                  : typeId.value == 2
                      ? ColorManager.orange
                      : typeId.value == 3
                          ? ColorManager.red
                          : ColorManager.blue,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${name}",
                            style: getMFStyle(
                                color: ColorManager.greyDark,
                                fontSize: FontSize.s14)),
                        Text("Father: ${fatherName}",
                            style: getMFStyle(
                                color: ColorManager.greyDark,
                                fontSize: FontSize.s14)),
                      ],
                    ),
                    Text("Roll: ${roll} ",
                        style: getMFStyle(
                            color: ColorManager.greyDark,
                            fontSize: FontSize.s14)),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAttendanceChip(
                        backColor: ColorManager.green,
                        label: "Present",
                        value: 1,
                        currentValue: typeId),
                    _buildAttendanceChip(
                        backColor: ColorManager.red,
                        label: "Absent",
                        value: 2,
                        currentValue: typeId),
                    _buildAttendanceChip(
                      backColor: ColorManager.orange,
                      label: "Leave",
                      value: 3,
                      currentValue: typeId,),
                    _buildAttendanceChip(
                        backColor: ColorManager.blue,
                        label: "NA",
                        value: 4,
                        currentValue: typeId)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadio(
      {required String label,
      required Color activeColor,
      required int value,
      required Rx<int> currentVal}) {
    return Row(
      children: [
        Obx(
          () => Radio<int>(
            value: value,
            groupValue: currentVal.value,
            onChanged: (value) {
              currentVal.value = value!;
              controller.changeRadioType();
            },
            activeColor: activeColor,
          ),
        ),
        Text(
          label,
          style: getRFStyle(color: activeColor, fontSize: FontSize.s14),
        )
      ],
    );
  }

  Widget _buildAttendanceChip({
    required Color backColor,
    required String label,
    required Rx<int> currentValue,
    required int value,
  }) {
    return InkWell(
      onTap: () {
        currentValue.value = value;
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: currentValue == value
                  ? backColor.withOpacity(0.3)
                  : Colors.transparent,
              border: Border.all(style: BorderStyle.solid, color: backColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(label,
                style: getMFStyle(color: backColor, fontSize: FontSize.s12)),
          ),
        ),
      ),
    );
  }
}
