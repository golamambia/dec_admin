import 'dart:convert';
import 'dart:typed_data';

import 'package:decora_admin/online_exam/view/questions/add_descriptive_question.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resource/color_manager.dart';
import '../../../../../resource/font_manager.dart';
import '../../../../../resource/styles_manager.dart';
import '../../../../../util/ams.dart';
import '../../controller/paper_controller.dart';
import 'list_item_descriptive.dart';



class ListQuestionDescriptive extends GetView<PaperController> {


  var fileName = TextEditingController();
  Uint8List? bytes;
  String base64Str = "";
  String fileType = "";

  @override
  Widget build(BuildContext context) {
    controller.fetchDesPaper();
    return Scaffold(
      appBar:  AppBar(
        leading: BackButton(color: ColorManager.white,onPressed: () => Get.back(),),

        backgroundColor: ColorManager.primary,
        title: Text(
          "Set Questions",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
/*
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                //todo
                _pinDialog();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primaryMedium,
                  minimumSize: Size(80.w, 20.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Upload",
                style: getMFStyle(
                    color: ColorManager.white, fontSize: FontSize.s14),
              ),
            ),
          )        ],
*/

      ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Text("DESCRIPTIVE",style: getSFStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),),
              ),
              StreamBuilder(
                  stream: controller.desPaperModel.stream,
                  builder: (BuildContext context,
                       snapshot) {
                    if (snapshot.data != null) {
                      if(!snapshot.hasData){
                        return Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Text("No data found",style: TextStyle(fontSize: FontSize.s18),),
                        );
                      }
                      // examService.updateSelectedAttendanceStatus();
                      return  ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListItemDescriptive(
                                  records:snapshot.data!.records![index],
                              )
                          );
                        },
                        itemCount: snapshot.data?.records?.length??0,
                      );
                    }
                    return SizedBox();
                  }),

            ],),
        ),
      )

      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: ()async {
          controller.reSetFormMcq();
          Get.to(()=>AddDescriptiveQuestion());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add, size: 32.h),
      ),
    );
  }

  Widget controllerButton(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          SizedBox(
            height: 40,
            child:
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.grey,
                  minimumSize: Size(100.w, 33.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Cancel",
                style: getMFStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14),
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
            child:ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  minimumSize: Size(100.w, 33.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Save",
                style: getMFStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }


  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: false,
        allowedExtensions: ["xlsx"],
        type: FileType.custom);

    double sizeInMB = result!=null? result!.files[0].size/1000000:0;


    if (result != null && sizeInMB<=4.0) {
      bytes = result.files[0].bytes;
      base64Str = base64.encode(bytes!);
      fileName.text = result.files.first.name;
      // print(base64Str);
      // Get.log(base64Str);
      if(result.files[0].extension.toString()=="pdf"){
        fileType=result.files[0].extension.toString();
      }else{
        fileType="IMG";

      }

      // _ns.saveNotice(bytes: bytes.toString());
      // print(result.files.first.name);
      // print(result.files.first.size);
      // print(result.files.first.path);
    }else if(result!=null){
      Ams.ft("file size must be under 4MB");
    }
  }


  _pinDialog() => showDialog(
      context: Get.context!,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r)),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 28.h),
          width: Get.width - 40.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Upload",
                style: getBFStyle(
                    color: ColorManager.black, fontSize: FontSize.s16),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextButton(onPressed: () {
                // SyllabusController sylController = SyllabusController();
                // sylController.downloadSyllabusFiles("http://latestapp.decorainfotech.in/Document/Sample_Des_Question.xlsx");
                // EasyLoading.dismiss();
              }, child: Text("download sample sheet")),
              SizedBox(
                height: 10.h,
              ),


              TextFormField(
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Your Pin Code";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: fileName,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "chooseFile",
                  hintStyle: getRFStyle(
                      color: ColorManager.grey, fontSize: FontSize.s14),
                  suffixIcon: InkWell(
                      onTap: () async {
                        _pickFile();
                      },
                      child: Icon(
                        Icons.file_upload,
                        color: ColorManager.black,
                        size: 24.h,
                      )),
                  border: const OutlineInputBorder(),
                ),
                style: getRFStyle(
                    color: ColorManager.black, fontSize: FontSize.s14),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.grey,
                        minimumSize: Size(112.w, 33.h),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    child: Text(
                      "Cancel",
                      style: getMFStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s14),
                    ),
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // examService.uploadmcqSheet(type: "Des",examId: widget.examRecord.examID!, subId: widget.examRecord.subjectID!, clsId: widget.clsId, bytes: base64Str);
                      Get.back();
                      base64Str="";
                      fileName.text="";
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        minimumSize: Size(112.w, 33.h),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    child: Text(
                      "Submit",
                      style: getMFStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));

}
