import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/common/model/class_list.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/notice/controller/notice_controller.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/util/date_utils.dart';
import 'package:decora_admin/util/file_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../controller/online_cls_controller.dart';

class OnlineClsUpdatePage extends GetView<OnlineClsController> {

  OnlineClsUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () {
            controller.reset();
            Get.back();
          },
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Update Online Class",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    MultiSelectCls(controller.clsController),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.title,
                        label: "Online Class Title"),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextFormField(
                        vfn: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is required";
                          }
                          if(!value.startsWith("https://")){
                            return "Please enter proper link e.g https://www.google.com";
                          }
                          return null;
                        },

                        controller: controller.link,
                        label: "Online Class Link"),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.time,
                        label: "Online Class Time"),
                    SizedBox(
                      height: 10.h,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    _buildDateTextFormField(
                        vfn: controller.emptyValidation,
                        controller: controller.date,
                        label: "Date"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Is Active",
                          style: getMFStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16),
                        ),
                        Row(
                          children: [
                            Obx(() => Radio<bool>(
                                  value: true,
                                  groupValue: controller.isLive.value,
                                  onChanged: (value) {
                                    controller.isLive.value = value!;
                                  },
                                )),
                            // SizedBox(width: 5.0),
                            const Text("True"),
                          ],
                        ),
                        const SizedBox(width: 10.0),
                        Row(
                          children: [
                            Obx(() => Radio<bool>(
                                  value: false,
                                  groupValue: controller.isLive.value,
                                  onChanged: (value) {
                                    controller.isLive.value = value!;
                                  },
                                )),
                            // SizedBox(width: 5.0),
                            const Text("False"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.onUpdate( );
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(240.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Text(
                        "Update",
                        style: getMFStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      {required TextEditingController controller,
      required String label,
      TextInputType inputType = TextInputType.text,
      String? Function(String?)? vfn,
      minLine = 1,
      enabled = true,
      bool secure = false,
      IconData? icon}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: secure,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          label: Text(label,
              style: getMFStyle(
                  color: ColorManager.primary, fontSize: FontSize.body)),
          suffixIcon: Icon(icon),
          border: OutlineInputBorder()),
      maxLines: minLine,
      // minLines: ,
      validator: vfn,
    );
  }

  TextFormField _buildChooseFileTextFormField(
      {required TextEditingController controller,
      required String label,
      TextInputType inputType = TextInputType.text,
      String? Function(String?)? vfn,
      minLine = 1,
      enabled = true,
      bool secure = false,
      required void Function()? onTap,
      IconData? icon}) {
    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      controller: controller,
      obscureText: secure,
      readOnly: true,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          label: Text(label,
              style: getMFStyle(
                  color: ColorManager.primary, fontSize: FontSize.body)),
          suffixIcon: Icon(icon),
          border: OutlineInputBorder()),
      maxLines: minLine,
      // minLines: ,
      validator: vfn,
    );
  }

  TextFormField _buildDateTextFormField(
      {required TextEditingController controller,
      required String label,
      TextInputType inputType = TextInputType.text,
      String? Function(String?)? vfn,
      // void Function()? onTap,
      minLine = 1,
      enabled = true,
      bool secure = false,
      IconData? icon = Icons.calendar_month}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: secure,
      keyboardType: inputType,
      readOnly: true,
      onTap: () async {
        controller.text = await CustomDateUtils.datePicker();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          label: Text(label,
              style: getMFStyle(
                  color: ColorManager.primary, fontSize: FontSize.body)),
          suffixIcon: Icon(icon),
          border: OutlineInputBorder()),
      maxLines: minLine,
      // minLines: ,
      validator: vfn,
    );
  }

  Obx _buildSelectionTextField({
    required List<String> days,
    required Rx<String> dayType,
    String? Function(String?)? vfn,
  }) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
        value: dayType.isEmpty ? null : dayType.value,
        hint: Text(
          'Please Select Day Type',
          style: getRFStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        ),
        validator: vfn,
        isExpanded: true,
        style: getRFStyle(color: ColorManager.black, fontSize: FontSize.s14),
        items: days
            .map(
              (val) => DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                  style: getRFStyle(
                      color: ColorManager.black, fontSize: FontSize.s14),
                ),
              ),
            )
            .toList(),
        onChanged: (String? val) {
          dayType.value = val ?? "";
        },
      ),
    );
  }
}
