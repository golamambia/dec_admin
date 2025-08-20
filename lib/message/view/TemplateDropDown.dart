import 'package:decora_admin/message/controller/message_controller.dart';
import 'package:decora_admin/message/model/message_model.dart';
import 'package:decora_admin/message/service/message_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Templatedropdown extends GetView<MessageController> {
  Templatedropdown({super.key});


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> DropdownButtonFormField2<MessageRecord>(
        isExpanded: true,
        decoration: InputDecoration(
          // Add Horizontal padding using menuItemStyleData.padding so it matches
          // the menu padding when button's width is not specified.
          contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          // Add more decoration..
        ),
        hint: const Text(
          'Select Message Template',
          style: TextStyle(fontSize: 14),
        ),
        items: controller.messageService.messageModel.value.records
            .map((item) => DropdownMenuItem<MessageRecord>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      item.message??"",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select template';
          }
          return null;
        },
        onChanged: (value) {
          controller.message.value.text = value?.messageTitle??"";
          controller.templateId = value?.tempid??"";
          controller.messageCharCount.value=controller.message.value.text.length;
          Get.log('cons ${ value?.messageTitle??""}');        },
        // onSaved: (value) {
        //   controller.message.value.text = value?.messageTitle??"";
        //   Get.log('cons ${ value?.messageTitle??""}');
        // },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
