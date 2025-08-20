import 'package:decora_admin/online_exam/controller/exam_controller.dart';
import 'package:decora_admin/online_exam/controller/paper_controller.dart';
import 'package:decora_admin/online_exam/model/exam_model.dart';
import 'package:decora_admin/online_exam/view/questions/list_question_descriptive.dart';
import 'package:decora_admin/online_exam/view/questions/list_question_objective.dart';
import 'package:decora_admin/online_exam/view/subject/subject_Update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' hide TrimMode, ReadMoreText;

import '../../../../../resource/color_manager.dart';
import '../../../../../resource/styles_manager.dart';

class SubRecordItme extends GetView<ExamController> {
  SubRecordItme({Key? key, required this.examRecord}) : super(key: key);
  var isSelected = false.obs;
  var f1;
  ExamRecords examRecord;

  // String clsId;
  String schoolCode = getStringAsync("schoolCode");

  @override
  Widget build(BuildContext context) {
    isSelected.value = examRecord.isActive == "True" ? true : false;

    // Get.log(examRecord.examDate.toString());

    // DateFormat dateFormat = DateFormat('M/d/yyyy h:mm:ss a');
    // DateTime dateTime = dateFormat.parse(examRecord.examDate.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 5,
                    blurRadius: 10)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorManager.primaryLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: examRecord.subjectName.toString(),
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            // TextSpan(text: examRecord.subjectName.toString()),
                          ],
                        ),
                      ),
/*
                      SizedBox(
                          height: 25,
                          child: Obx(() {
                            return Switch(
                              value: isSelected.value,
                              onChanged: (value) async {},
                              inactiveTrackColor: Colors.white,
                              activeTrackColor: Colors.white,
                              activeColor: Colors.lightBlue.shade900,
                              inactiveThumbColor: Colors.grey,
                            );
                          }))
*/
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Time-in : ',
                                    style: getSFStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(text: examRecord.timeIn),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Time-out : ',
                                    style: getSFStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(text: examRecord.timeOut),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Duration : ',
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: examRecord.duration),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Max-Mark : ',
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: examRecord.maxMarks),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5).copyWith(bottom: 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Objective(Q) no. :',
                                    style: getSFStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: examRecord.objQuesNo.toString()),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                                onTap: () async {
                                  // Get.to(() =>
                                  //     ListQuestionObjective(examRecord: examRecord,clsId:clsId));
                                  Get.to(()=>ListQuestionObjective(),binding: BindingsBuilder.put(()=>PaperController()));
                                },
                                child: CircleAvatar(
                                  radius: 10.r,
                                  child: Icon(
                                    Icons.add,
                                    color: ColorManager.primary,
                                    size: 15,
                                  ),
                                ))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Objective(Q) Mark. :',
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: examRecord.objQuesMarks),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5).copyWith(bottom: 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Descriptive (Q) no. :',
                                    style: getSFStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(text: examRecord.desQuesNo),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                                onTap: () async {

                                  Get.to(()=>ListQuestionDescriptive() ,binding: BindingsBuilder.put(()=>PaperController()));
                                },
                                child: CircleAvatar(
                                  radius: 10.r,
                                  child: Icon(
                                    Icons.add,
                                    color: ColorManager.primary,
                                    size: 15,
                                  ),
                                ))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Descriptive (Q) Mark. :',
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(text: examRecord.desQuesMarks),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 1,
                  child: Divider(
                    thickness: 1,
                  )),
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Date: ',
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: examRecord.examDate,
                              style: getSFStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () async{
                            await controller.examService.deleteExamSubject(onlineSubId: examRecord.onlineExamClassSubjectMappID??"");
                            controller.fetchExamSubList();
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: ColorManager.stateDanger.withOpacity(.5),
                            child: Icon(
                              Icons.delete_forever,
                              color: ColorManager.stateDanger,
                              size: 15,
                            ),
                          )
                          ),
                      GestureDetector(
                          onTap: () {
                            controller.setSubjectForm(examRecord);
                            Get.to(()=>SubjectUpdatePage());
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            child: Icon(
                              Icons.edit_note,
                              color: ColorManager.primary,
                              size: 15,
                            ),
                          )
                          ),
                    ]),
              ),
            ],
          )),
    );
  }
}
