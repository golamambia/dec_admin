import 'package:decora_admin/mark/model/student_mark_model.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:popover/popover.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/mark_controller.dart';

class MarkCard extends GetView<MarkController> {
  // const MarkCard({super.key});
  var _mark = TextEditingController();
  var grade = "".obs;

  late StudentMarkRecords studentRecord;
  late var colorIndex;

  //for switch marks
  var isMake = true;

  MarkCard(
      {super.key,
      required this.studentRecord,
      required this.colorIndex,
      required typeName}) {
    isMake = typeName == "Main" ? true : false;
    _mark.text = studentRecord.marks ?? "";
    grade.value = studentRecord.grade ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => _popMenu(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.top,
          width: 250.w,
          height: 150.h,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  width: 320.w,
                  decoration: BoxDecoration(
                      color: Ams.cardTitleColor[colorIndex],
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10.r))),
                  child: Text(
                    studentRecord.sT_Name ?? "",
                    textAlign: TextAlign.center,
                    style: getBFStyle(
                        color: ColorManager.white, fontSize: FontSize.title2),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextRow(
                    label: "Guardian Name",
                    value: studentRecord.guardianName ?? ""),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextRow(
                    label: "Max Mark", value: controller.exam_max_mark ?? ""),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: ColorManager.greyDark,
                ),
/*
                Container(
                  height: 20.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text("Marks Field : "),
                      TextFormField(controller: markController, expands: true ,maxLines: null,minLines: null, decoration: InputDecoration(border: OutlineInputBorder()),),
                    ],
                  ),
                ),
*/

                Container(
                  child: isMake ? _buildMark() : _buildGrade(),
                ),
                // _buildMark(),
                //
                // _buildGrade(),

                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildGrade() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Grade Field : ",
            style:
                getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
              // border: Border.fromBorderSide(BorderSide(
              //     width: 1, color: ColorManager.grey))
            ),
            width: 90.0,
            height: 25,
            child: Container(
              padding: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.fromBorderSide(
                      BorderSide(width: 1, color: ColorManager.grey))),
              width: 90.0,
              height: 20,
              child: Center(
                  child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: grade.value == "" ? null : grade.value,
                    items:
                        controller.markService.studentMarkModel.value.academics!
                            .map((item) => DropdownMenuItem<String>(
                                  value: item.grade,
                                  child: Text(item.grade!,
                                      style: getRFStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s13)),
                                ))
                            .toList(),
                    onChanged: (value) {
                      studentRecord.grade = value;
                      grade.value = value!;
                    },
                    // style: Theme.of(context).textTheme.title,
                  ),
                ),
              )),
            )),
      ],
    );
  }

  Row _buildMark() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text(
            "Mark Field : ",
            style:
                getMFStyle(color: ColorManager.black, fontSize: FontSize.s16),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(10),
            // border: Border.fromBorderSide(BorderSide(
            //     width: 1, color: ColorManager.grey))
          ),
          width: 90.0,
          height: 25,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: _mark,
            onChanged: (value) {
              var max = double.tryParse(controller.exam_max_mark) ?? 0.0;
              _mark.text = value;
              studentRecord.marks = value;

              final numericRegex = RegExp(r'^-?\d+(\.\d+)?$');
              bool hasMatch = numericRegex.hasMatch(value);

              if (hasMatch) {
                double entered = double.parse(value);

                if (entered <= max) {
                  _mark.text = value;
                  studentRecord.marks = value;
                } else {
                  Ams.ft("You are exceeding max marks limit!!!");
                  // Remove last entered character
                  String trimmed = value.substring(0, value.length - 1);
                  _mark.text = trimmed;
                  studentRecord.marks = trimmed;
                }
              }
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ),
      ],
    );
  }

  Padding _popMenu() {
    var context = Get.context!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)..pop();
              // controller.onDeleteItem(studentId:studentRecord.homeworkID!);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Delete',
                      style: getMFStyle(
                          color: ColorManager.white, fontSize: FontSize.title2),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context)..pop();
              // controller.setFormValue(homeworkRecord: studentRecord);
              // Get.to(()=>MarkUpdatePage());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Edit',
                      style: getMFStyle(
                          color: ColorManager.white, fontSize: FontSize.title2),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTextRow(
      {required String label, required String value, Color? color}) {
    return Row(
      children: [
        Text(
          "${label} : ",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // textAlign: TextAlign.center,
          style: getMFStyle(
              color: color ?? ColorManager.greyDark, fontSize: FontSize.body),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // textAlign: TextAlign.center,
          style:
              getRFStyle(color: ColorManager.greyDark, fontSize: FontSize.body),
        ),
      ],
    );
  }
}
