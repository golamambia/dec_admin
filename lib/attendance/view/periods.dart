import 'package:decora_admin/attendance/controller/attendance_controller.dart';
import 'package:decora_admin/attendance/model/periods_model.dart';
import 'package:decora_admin/attendance/view/routine_item.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



import '../../../../resource/color_manager.dart';
import '../../../../resource/font_manager.dart';
import '../../../../resource/styles_manager.dart';
import '../model/attendance_model.dart';

class Periods extends GetView<AttendanceController> {
  Periods({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: ColorManager.white,onPressed: () => Get.back(),),

        backgroundColor: ColorManager.primary,
        title: Text(
          "Periods",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // height: 40,
                  child: BuildDateTextFormField(controller: controller.currentDatePeriod, label: "Select Date",callBack: controller.empDatePeriodCallBack),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Text(
                    "Routine",
                    textAlign: TextAlign.center,
                    style: getRFStyle(
                        color: ColorManager.white, fontSize: FontSize.s14),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                StreamBuilder(
                    stream: controller.empPeriodsModel.stream,
                    builder: (BuildContext context,
                        snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.records!.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Text(
                              "No data found",
                              style: TextStyle(fontSize: FontSize.s18),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.records!.length,
                          itemBuilder: (_, i) {
                            return periodsRow(
                                ColorManager.primaryLight, snapshot.data!.records![i]);
                          },
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Text("Please select Date",style: TextStyle(fontSize: FontSize.s18),),
                      );
                    }),
              ],
            ),
          )),
    );
  }

  Widget periodsRow(Color color, PeriodsRecord record) {
    Get.log("Periods: ${record.emp_Name}");
    Get.log("Periods: ${record.objPeriodStatusModel?.first.period}");
    return InkWell(
      // onLongPress: () => Get.to(() => AddNotice(),arguments: {"info":record}),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(color: color),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Teacher Name  : ",
                  style: getBFStyle(
                      color: ColorManager.black, fontSize: FontSize.s13),
                ),
                Text(
                  record.emp_Name.toString(),
                  style: getRFStyle(
                      color: ColorManager.black, fontSize: FontSize.s13),
                  softWrap: true,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150.h,
              child: GridView.builder(physics: NeverScrollableScrollPhysics(),
                  itemCount: record.objPeriodStatusModel!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing:0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 6,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return RoutineItem(statusModel: record.objPeriodStatusModel![index],
                      tID: record.emP_ID.toString(),
                      dayCode: record.emp_Code.toString(),
                    );
                  }),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       flex: 4,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //
            //         ]
            //       ),
            //     ),
            //     Expanded(
            //       flex: 6,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: []
            //       ),
            //     ),
            //   ],
            // )

            SizedBox(
                height: 1,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ))
          ],
        ),
      ),
    );
  }
}
