import 'dart:convert';
import 'dart:io';

import 'package:decora_admin/online_exam/controller/paper_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resource/color_manager.dart';
import '../../../../../resource/font_manager.dart';
import '../../../../../resource/styles_manager.dart';
import '../../../../../util/ams.dart';

class AddObjectiveQuestion extends GetView<PaperController> {
  AddObjectiveQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            controller.reSetFormMcq();
            Get.back();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Set Questions",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(controller.focus1),
                          controller: controller.questionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter question';
                            }
                            return null;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Question",
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                pickFile("q");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.primary,
                                  // minimumSize: Size( 33.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                "Choose(Q) file",
                                style: getMFStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s14),
                              ),
                            ),
                            Obx(() => controller.questionFilePath.value == ""
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: 100,
                                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                                    child: Image.file(
                                      File(controller.questionFilePath.value),
                                      fit: BoxFit.cover,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Answer1"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(controller.focus2),
                          focusNode: controller.focus1,
                          controller: controller.choice1Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter answer';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Answer",
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correct  : ",
                                      style: getBFStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s13),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: Obx(() => Switch(
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              ColorManager.orange,
                                          activeTrackColor: ColorManager.green,
                                          value: controller.isActive1.value,
                                          onChanged: (value) async {
                                            controller.isActive1.value = value;
                                            controller.isActive2.value = false;
                                            controller.isActive3.value = false;
                                            controller.isActive4.value = false;
                                            controller.selected = '1';
                                            // f();
                                          })),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    pickFile("c1");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      // minimumSize: Size( 33.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "Choose(A) file",
                                    style: getMFStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => controller.answer1FilePath.value == ""
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: 100,
                                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                                    child: Image.file(
                                      File(controller.answer1FilePath.value),
                                      fit: BoxFit.cover,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Answer2"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: controller.focus2,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(controller.focus3),
                          maxLines: 1,
                          controller: controller.choice2Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter answer';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Answer",
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correct  : ",
                                      style: getBFStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s13),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: Obx(() => Switch(
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              ColorManager.orange,
                                          activeTrackColor: ColorManager.green,
                                          value: controller.isActive2.value,
                                          onChanged: (value) async {
                                            controller.isActive2.value = value;
                                            controller.isActive1.value = false;
                                            controller.isActive3.value = false;
                                            controller.isActive4.value = false;
                                            controller.selected = '2';
                                            // f();
                                          })),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    pickFile("c2");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      // minimumSize: Size( 33.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "Choose(A) file",
                                    style: getMFStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => controller.answer2FilePath.value == ""
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: 100,
                                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                                    child: Image.file(
                                      File(controller.answer2FilePath.value),
                                      fit: BoxFit.cover,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Answer3"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: controller.focus3,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(controller.focus4),
                          controller: controller.choice3Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter answer';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Answer",
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correct  : ",
                                      style: getBFStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s13),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: Obx(() => Switch(
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              ColorManager.orange,
                                          activeTrackColor: ColorManager.green,
                                          value: controller.isActive3.value,
                                          onChanged: (value) async {
                                            controller.isActive3.value = value;
                                            controller.isActive1.value = false;
                                            controller.isActive2.value = false;
                                            controller.isActive4.value = false;
                                            controller.selected = '3';
                                            // f();
                                          })),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    pickFile("c3");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      // minimumSize: Size( 33.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "Choose(A) file",
                                    style: getMFStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => controller.answer3FilePath.value == ""
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: 100,
                                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                                    child: Image.file(
                                      File(controller.answer3FilePath.value),
                                      fit: BoxFit.cover,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Answer4"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          focusNode: controller.focus4,
                          textInputAction: TextInputAction.done,
                          controller: controller.choice4Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter answer';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Answer",
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Correct  : ",
                                      style: getBFStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s13),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: Obx(() => Switch(
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              ColorManager.orange,
                                          activeTrackColor: ColorManager.green,
                                          value: controller.isActive4.value,
                                          onChanged: (value) async {
                                            controller.isActive4.value = value;
                                            controller.isActive1.value = false;
                                            controller.isActive2.value = false;
                                            controller.isActive3.value = false;
                                            controller.selected = '4';
                                            // f();
                                          })),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    pickFile("c4");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.primary,
                                      // minimumSize: Size( 33.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "Choose(A) file",
                                    style: getMFStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => controller.answer4FilePath.value == ""
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: 100,
                                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                                    child: Image.file(
                                      File(controller.answer4FilePath.value),
                                      fit: BoxFit.cover,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                controllerButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget controllerButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.grey,
                  minimumSize: Size(100.w, 33.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Cancel",
                style: getMFStyle(
                    color: ColorManager.white, fontSize: FontSize.s14),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                controller.onSaveMcq();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  minimumSize: Size(100.w, 33.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Save",
                style: getMFStyle(
                    color: ColorManager.white, fontSize: FontSize.s14),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  pickFile(String fileFor) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['img', 'png', 'jpeg']);
    double sizeInMB = result != null ? result!.files[0].size / 1000000 : 0;
    if (result != null && sizeInMB <= 4.0) {
      File files = File(result.files[0].path.toString());
      final fdata = File(files.path).readAsBytesSync();
      switch (fileFor) {
        case "q":
          controller.questionFile = base64Encode(fdata);
          controller.questionFilePath.value = files.path;
          break;
        case "c1":
          controller.answer1File = base64Encode(fdata);
          controller.answer1FilePath.value = files.path;
          break;
        case "c2":
          controller.answer2File = base64Encode(fdata);
          controller.answer2FilePath.value = files.path;
          break;
        case "c3":
          controller.answer3File = base64Encode(fdata);
          controller.answer3FilePath.value = files.path;
          break;
        case "c4":
          controller.answer4File = base64Encode(fdata);
          controller.answer4FilePath.value = files.path;
          break;
      }
    } else if (result != null) {
      Ams.ft("file size must be under 4MB");
    }
  }

/* void insertQuestion() async {
    if (_formKey.currentState!.validate()) {
      if (selected != "") {
        var data = await paperController.addQuestion(QuestionPayload(
            clsId: clsId,
            subId: examRecord.subjectID,
            examID: examRecord.examID,
            isActive: examRecord.isActive,
            type: "InsertQuestion",
            decSchoolCode: schoolCode,
            choice1: choice1Controller.text,
            choice1FileData: answer1File,
            choice2: choice2Controller.text,
            choice2FileData: answer2File,
            choice3: choice3Controller.text,
            choice3FileData: answer3File,
            choice4: choice4Controller.text,
            choice4FileData: answer4File,
            correctAnswer: selected,
            hints: "",
            question: questionController.text,
            questionFileData: questionFile,
            questionMarks: examRecord.objQuesMarks,
            questionType: "Obj"));
        if (data) {
          Get.back(result: {true});
        }
      } else {
        Ams.ft("Please select correct answer!");
      }
    }
  }*/
}
