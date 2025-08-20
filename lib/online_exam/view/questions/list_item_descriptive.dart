import 'package:decora_admin/online_exam/controller/paper_controller.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/model/paper_model.dart';
import 'package:decora_admin/online_exam/view/questions/update_descriptive_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../../resource/color_manager.dart';
import '../../../../../resource/styles_manager.dart';
import '../../../resource/assets_manger.dart';


class ListItemDescriptive extends GetView<PaperController> {
  ListItemDescriptive({Key? key,required this.records}) : super(key: key);

  PaperRecord records;


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
              child: Text( records.question.toString(),
                style: getSFStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(records.correctAnswer.toString())
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
                child: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){
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
                                        controller.fetchDesPaper();
                                        Get.back();

                                      },
                                      child: Text("Delete",
                                          style: TextStyle(
                                              color: ColorManager.stateDanger))),
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
                          // SvgPicture.asset(ImageAssets.delete),
                          Icon(Icons.delete_forever,color: Colors.red,),
                          SizedBox(width: 5,),
                          Text("Delete",style: TextStyle(color: Colors.red),)
                        ],
                      ),
                    ),
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: ()async{
                       // var data = await Get.to(()=>UpdateDescriptiveQuestion(examRecord:records ,));
                       // if(data!=null){
                       //   examService.getQuestions("Des",examID: records.examID!,clsId: records.clsID!,subId: records.subID!);
                       // }
                        controller.currentDesRecord=records;
                        controller.setFormDes();
                        Get.to(()=>UpdateDescriptiveQuestion());

                      },
                      child: Row(
                        children: [
                          // SvgPicture.asset(ImageAssets.editBlue2),
                          Icon(Icons.edit_note,color: ColorManager.primary,),
                          SizedBox(width: 5,),
                          Text("Edit",style: TextStyle(color: Colors.blueAccent),)
                        ],
                      ),
                    ),
                  ],)
            ),
          ],
        ));
  }
}
