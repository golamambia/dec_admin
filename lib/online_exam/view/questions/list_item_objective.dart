import 'package:decora_admin/online_exam/controller/paper_controller.dart';
import 'package:decora_admin/online_exam/view/questions/update_objective_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../resource/color_manager.dart';
import '../../../../../resource/styles_manager.dart';
import '../../../resource/assets_manger.dart';
import '../../model/paper_model.dart';

class ListItemObjective extends GetView<PaperController> {
  ListItemObjective(
      {Key? key, required this.records, required this.size, required this.f})
      : super(key: key);
  PaperRecord records;

  // var isSelected = false.obs;
  // final ExamService exam = Get.put(ExamService());
  // ExamRecords data;
  int size;

  Function f;

  @override
  Widget build(BuildContext context) {
    // isSelected.value = data.isActive == "True" ? true : false;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400, spreadRadius: 5, blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorManager.primaryMedium,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Text(
                records.question ?? "",
                style: getSFStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      child: Text("1. ${records.choice1.toString()}")),
                  Padding(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      child: Text("2. ${records.choice2.toString()}")),
                  Padding(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      child: Text("3. ${records.choice3.toString()}")),
                  Padding(
                      padding: const EdgeInsets.all(
                        5,
                      ),
                      child: Text("4. ${records.choice4.toString()}")),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorManager.primaryMedium,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (contet) {
                              return AlertDialog(
                                title: Text("Delete"),
                                content: Text("Would you like to delete?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        controller.onDeleteMcqAndDes(questionId: records.questionID??"");
                                        Get.back();
                                      },
                                      child: Text("Delete",
                                          style: TextStyle(
                                              color:
                                                  ColorManager.stateDanger))),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("No")),
                                ],
                              );
                            });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.iconError),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        controller.currentMcqRecord = records;
                        controller.setFormMcq();
                        Get.to(()=>UpdateObjectiveQuestion());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.iconError),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(color: Colors.blueAccent),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
