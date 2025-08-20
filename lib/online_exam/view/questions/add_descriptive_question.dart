import 'dart:convert';
import 'dart:io';

import 'package:decora_admin/online_exam/controller/paper_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../../../../resource/color_manager.dart';
import '../../../../../resource/font_manager.dart';
import '../../../../../resource/styles_manager.dart';
import '../../../../../util/ams.dart';

class AddDescriptiveQuestion extends GetView<PaperController> {
  AddDescriptiveQuestion({Key? key})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();




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
          "Set Questions",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(controller.focus1),
                  maxLines: 4,
                  controller:controller.questionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter question';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Question",
                      hintStyle: TextStyle(fontSize: 15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(() => controller.questionFilePath.value == ""
                    ? SizedBox()
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(controller.questionFilePath.value),
                          fit: BoxFit.cover,
                        ),
                      )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  maxLines: 1,
                  readOnly: true,
                  onTap: () {
                    pickFile();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Question File",
                      hintStyle: TextStyle(fontSize: 15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(5))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  focusNode: controller.focus2,
                  controller: controller.answerController,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter answer';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Answer",
                      hintStyle: TextStyle(fontSize: 15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                SizedBox(
                  height: 50,
                ),
                controllerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['img', 'png', 'jpeg']);

    double sizeInMB = result != null ? result!.files[0].size / 1000000 : 0;
    print(sizeInMB);

    if (result != null && sizeInMB <= 4.0) {
      File files = File(result.files[0].path.toString());
      final fdata = File(files.path).readAsBytesSync();
      controller.questionFile = base64Encode(fdata);
      controller.questionFilePath.value = files.path;
    } else if (result != null) {
      Ams.ft("file size must be under 4MB");
    }
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
                controller.onSaveDes();
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
}
