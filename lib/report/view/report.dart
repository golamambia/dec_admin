//import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import 'package:decora_admin/report/view/reportDownload.dart';


class Report extends GetView<AttendanceController> {
  const Report({super.key});

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
          "Report",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
        // actions: <Widget>[
        //   PopupMenuButton<String>(
        //     // onSelected: handleClick,
        //     itemBuilder: (BuildContext context) {
        //       return {'Student', 'Teacher'}.map((String choice) {
        //         return PopupMenuItem<String>(
        //           value: choice,
        //           child: Text(choice),
        //         );
        //       }).toList();
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            

            StreamBuilder(
              stream: controller.attendanceModel.stream,
              builder: (context, snapshot) {
                
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
           Align(
  alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding:  const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Notification",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    ElevatedButton(
                      onPressed: () {
                         Get.to(() => ReportDownload(title: "Notification Date Wise Report",type:'DateWise'));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          backgroundColor: ColorManager.blue,
                          minimumSize: Size(120.w, 120.h),
                          shape:  const CircleBorder()),
                       child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.calendar_today, color: Colors.white, size: 28),
                SizedBox(height: 8),
                Text(
                  "Date Wise",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                     ElevatedButton(
                      onPressed: () {
                        Get.to(() => ReportDownload(title: "Notification Class Report",type:'class_report'));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          backgroundColor: ColorManager.blue,
                          minimumSize: Size(120.w, 120.h),
                          shape:  const CircleBorder()),
                       child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.class_sharp, color: Colors.white, size: 28),
                SizedBox(height: 8),
                Text(
                  "Class Wise",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                
                    ElevatedButton(
                      onPressed: () {
                        //controller.isSMS=1;
                        //controller.onSave();
                        Get.to(() => ReportDownload(title: "Notification Student Report",type:'student_report'));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          backgroundColor: ColorManager.blue,
                         minimumSize: Size(120.w, 120.h),
                          shape:  const CircleBorder()),
                       child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  "Student Wise",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
                    ),
                SizedBox(
                      width: 10.w,
                    ),
                
                      ElevatedButton(
                      onPressed: () {
                      Get.to(() => ReportDownload(title: "Notification Teacher Report",type:'teacher_report'));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          backgroundColor: ColorManager.blue,
                          minimumSize: Size(120.w, 120.h),
                          shape:  const CircleBorder()),
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  "Teacher Wise",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
                    ),
                
                  ],
                ),
              ),
            ),
             
             Align(
  alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding:  const EdgeInsets.only(left: 12.0,bottom: 4.0,top:8.0),
                    child: Text(
                      "Substitution",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
Padding(
  padding: const EdgeInsets.all(12.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    
    children: [
      // First Box
      Expanded(
        flex: 1, // each takes 50%
        child: GestureDetector(
          onTap: () {
            Get.to(() => ReportDownload(title: "Absent Substitution"));
          },
          child: Container(
            height: 90.h,
            margin: const EdgeInsets.only(right: 8), // spacing between boxes
            decoration: BoxDecoration(
              color: ColorManager.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  "Absent Substitution",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
  
      // Second Box
      Expanded(
        flex: 1, // also 50%
        child: GestureDetector(
          onTap: () {
            Get.to(() => ReportDownload(title: "Substitution"));
          },
          child: Container(
            height: 90.h,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: ColorManager.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  "Substitution",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
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