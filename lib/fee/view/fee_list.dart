import 'package:decora_admin/fee/controller/fee_controller.dart';
import 'package:decora_admin/fee/view/fee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../model/fee_model.dart';

class FeeList extends GetView<FeeController> {
  const FeeList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getDetails();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Fee List",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
/*
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Get Past', 'Up coming'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
*/
      ),
      body: StreamBuilder<FeeModel>(
        stream: controller.feeModel.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 80.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            headerText(
                                label: "Total Fee",
                                amt: data.records?.last.fee??"0",
                                labelColor: ColorManager.stateInfo),

                            headerText(
                                label: "Total Fine",
                                amt: data.records?.last.fine??"0",
                                labelColor: ColorManager.stateDanger),

                            headerText(
                                label: "Total Amt",
                                amt: data.records?.last.amt??"0",
                                labelColor: ColorManager.green),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.records?.length == 0
                        ? 0
                        : data.records!.length - 1,
                    itemBuilder: (context, index) {
                      return FeeCard(
                        colorIndex: index % 3,
                        feeRecord: data.records![index],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }

  Column headerText({
    required label,
    required amt,
    required Color labelColor,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: getMFStyle(color: labelColor, fontSize: FontSize.s18),
        ),

        Text(
          "$amt /-",
          style: getBFStyle(color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
