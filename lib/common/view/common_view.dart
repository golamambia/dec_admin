import 'package:decora_admin/common/employee_controller.dart';
import 'package:decora_admin/common/controller/student_controller.dart';
import 'package:decora_admin/fee/model/installment_model.dart';
import 'package:decora_admin/fee/service/fee_service.dart';
import 'package:decora_admin/util/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../mark/model/mark_info_model.dart';
import '../controller/cls_controller.dart';
import '../controller/installment_controller.dart';
import '../model/employee_model.dart';
import '../model/student_model.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';
import '../common_service.dart';
import '../model/class_list.dart';

Widget MultiSelectCls(ClsController clsController) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: ColorManager.primary)),
    child: Obx(
          () {
        if (CommonService.classList.value.records.length > 0)
          return MultiSelectDialogField<ClassRecord>(
            initialValue: clsController.selectedClassList,
            buttonText: Text(clsController.classIds.value.isEmpty
                ? "select classes"
                : "select classes"),
            // buttonText: Text("select classes"),

            items: CommonService.classList.value.records
                .map((e) =>
                MultiSelectItem(e, "${e.className!} ${e.classSection}"))
                .toList(),
            chipDisplay: MultiSelectChipDisplay(
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All classes"),
                  Obx(
                        () =>
                        Checkbox(
                          value: clsController.isSelectAllCls.value,
                          onChanged: (value) {
                            clsController.isSelectAllCls.value = value!;
                            clsController.onSwitchClassListChange();
                            Get.back();
                          },
                        ),
                  )
                ],
              ),
            ),
            onConfirm: (list) {
              clsController.onConfirm(list);
              Get.log("onConfirm: ${list.toString()}");
            },
          );
        return Container(width: double.infinity,
            height: 20.h,
            child: Column(
              children: [
                LinearProgressIndicator(color: ColorManager.primary,),
                Text("Please Wait loading classes.."),
              ],
            ));
      },
    ),
  );
}

Widget MultiSelectInstallment(InstallmentController installmentController) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: ColorManager.primary)),
    child: Obx(
          () =>
          MultiSelectDialogField<InstallmentRecord>(
            initialValue: installmentController.selectedInstallmentList,
            buttonText: Text(installmentController.installmentIds.value.isEmpty
                ? "select installments"
                : "select installments"),
            // buttonText: Text("select installment"),

            items: FeeService.installmentModel.value.records!
                .map(
                    (e) =>
                    MultiSelectItem(e, "${e.insT_Name}"))
                .toList(),
            chipDisplay: MultiSelectChipDisplay(
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All installments"),
                  Obx(
                        () =>
                        Checkbox(
                          value: installmentController.isSelectAllInstallment
                              .value,
                          onChanged: (value) {
                            installmentController.isSelectAllInstallment.value =
                            value!;
                            installmentController
                                .onInstallmentListSwitchChange();
                            Get.back();
                          },
                        ),
                  )
                ],
              ),
            ),
            onConfirm: (list) {
              installmentController.onConfirm(list);
              Get.log("onConfirm: ${list.toString()}");
            },
          ),
    ),
  );
}

Widget MultiSelectStudents({
  required StudentController studentController
}) {
  return Container(
    decoration:
    BoxDecoration(border: Border.all(color: ColorManager.primary)),
    child: Obx(
          () =>
          MultiSelectDialogField<StudentRecord>(
            initialValue: studentController.selectedStudentList,
            buttonText: Text(studentController.studentsIds.value.isEmpty
                ? "Select Students"
                : "Select Students"),
            // buttonText: Text("select installment"),

            items: studentController.studentModel.value.records
                .map((e) => MultiSelectItem(e, "${e.sT_Name}"))
                .toList(),
            chipDisplay: MultiSelectChipDisplay(
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Students"),
                  Obx(
                        () =>
                        Checkbox(
                          value: studentController.isSelectAllStudent.value,
                          onChanged: (value) {
                            studentController.isSelectAllStudent.value = value!;
                            studentController.onStudentListSwitchChange();
                            Get.back();
                          },
                        ),
                  )
                ],
              ),
            ),
            onConfirm: (list) {
              studentController.onConfirm(list);
              Get.log("onConfirm: ${list.toString()}");
            },
          ),
    ),
  );
}

Widget MultiSelectEmployee({
  required EmployeeController employeeController
}) {
  return Container(
    decoration:
    BoxDecoration(border: Border.all(color: ColorManager.primary)),
    child: Obx(
          () =>
          MultiSelectDialogField<EmployeeRecord>(
            initialValue: employeeController.selectedEmployeeList,
            buttonText: Text(employeeController.empIds.value.isEmpty
                ? "Select Employees"
                : "Select Employees"),
            // buttonText: Text("select installment"),

            items: employeeController.employeeModel.value.records
                .map((e) => MultiSelectItem(e, "${e.emp_Name}"))
                .toList(),
            chipDisplay: MultiSelectChipDisplay(
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Employees"),
                  Obx(
                        () =>
                        Checkbox(
                          value: employeeController.isSelectAllEmployee.value,
                          onChanged: (value) {
                            employeeController.isSelectAllEmployee.value =
                            value!;
                            employeeController.onEmployeeListSwitchChange();
                            Get.back();
                          },
                        ),
                  )
                ],
              ),
            ),
            onConfirm: (list) {
              employeeController.onConfirm(list);
              Get.log("onConfirm: ${list.toString()}");
            },
          ),
    ),
  );
}

Widget SingleSelectCls({
  required Rx<String> clsId,
  String ?label,
  // required void Function(String?)? onChanged
  Function(String? s)? clsCallBack,
  Key? key
}) {
  return Obx(
        () =>
        DropdownButtonFormField(
          key: key,
          validator: (value) {
            value = value ?? "";
            if (value.isEmpty) {
              return "Field is required";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          value: clsId.isEmpty ? null : clsId.value,
          hint: Text(
            label ?? 'Please Select Class',
            style: getRFStyle(
                color: ColorManager.grey, fontSize: FontSize.s14),
          ),
          isExpanded: true,
          style: getRFStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
          items: CommonService.classList.value.records
              ?.map(
                (val) =>
                DropdownMenuItem<String>(
                  // onTap: () => clsName=val!.recordClass!,
                  value: val.classID,
                  child: Text(
                    "${val.className!} ${val.classSection}",
                    style: getRFStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14),
                  ),
                ),
          )
              .toList(),
          onChanged: (String? val) {
            clsId.value = val!;
            Get.log("class drop val : ${clsId.value}");
            clsCallBack?.call(val);
          },
        ),
  );
}

Widget SingleSelectSubject({
  required Rx<String> subId,
  required Rx<MarkInfoModel?> subjectModel,
  Function(String? s)? subCallBack,
  Key? key
}) {
  return Obx(
        () =>
        DropdownButtonFormField(
          key: key,
          validator: (value) {
            value = value ?? "";
            if (value.isEmpty) {
              return "Field is required";
            }
            return null;
          },

          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          value: subId.isEmpty ? null : subId.value,
          hint: Text(
            'Please Select Subject',
            style: getRFStyle(
                color: ColorManager.grey, fontSize: FontSize.s14),
          ),
          isExpanded: true,
          style: getRFStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
          items: subjectModel.value?.records
              ?.map(
                (val) =>
                DropdownMenuItem<String>(
                  // onTap: () => clsName=val!.recordClass!,
                  value: val.subjectID,
                  child: Text(
                    "${val.subjectName!}",
                    style: getRFStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14),
                  ),
                ),
          )
              .toList(),
          onChanged: (String? val) {
            subId.value = val!;
            Get.log("class Subject val : ${subId.value}");
            subCallBack?.call(val);
          },
        ),
  );
}

Widget SingleSelectExam({
  required Rx<String> examId,
  required Rx<MarkInfoModel?> examModel,
  Function(String? s)? examCallBack,
  Key? key
}) {
  return Obx(
        () =>
        DropdownButtonFormField(
          key: key,
          validator: (value) {
            value = value ?? "";
            if (value.isEmpty) {
              return "Field is required";
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          value: examId.isEmpty ? null : examId.value,
          hint: Text(
            'Please Select Exam',
            style: getRFStyle(
                color: ColorManager.grey, fontSize: FontSize.s14),
          ),
          isExpanded: true,
          style: getRFStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
          items: examModel.value?.records
              ?.map(
                (val) =>
                DropdownMenuItem<String>(
                  // onTap: () => clsName=val!.recordClass!,
                  value: val.examID,
                  child: Text(
                    "${val.examName!}",
                    style: getRFStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14),
                  ),
                ),
          )
              .toList(),
          onChanged: (String? val) {
            examId.value = val!;
            Get.log("class Subject val : ${examId.value}");
            examCallBack?.call(val);
          },
        ),
  );
}


TextFormField BuildTextFormField({required TextEditingController controller,
  required String label,
  TextInputType inputType = TextInputType.text,
  String? Function(String?)? vfn,
  String? Function(String?)? onChanged,
  minLine = 1,
  enabled = true,
  bool secure = false,
  IconData? icon}) {
  return TextFormField(
    enabled: enabled,
    controller: controller,
    obscureText: secure,
    keyboardType: inputType,
    onChanged: onChanged,
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

TextFormField BuildChooseFileTextFormField(
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

TextFormField BuildDateTextFormField({required TextEditingController controller,
  required String label,
  TextInputType inputType = TextInputType.text,
  String? Function(String?)? vfn,
  Function(String? s)? callBack,
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
      callBack?.call(controller.text);
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

TextFormField BuildTimeTextFormField({required TextEditingController controller,
  required String label,
  TextInputType inputType = TextInputType.text,
  String? Function(String?)? vfn,
  Function(String? s)? callBack,
  // void Function()? onTap,
  minLine = 1,
  enabled = true,
  bool secure = false,
  IconData? icon = Icons.access_time}) {
  return TextFormField(
    enabled: enabled,
    controller: controller,
    obscureText: secure,
    keyboardType: inputType,
    readOnly: true,
    onTap: () async {
      controller.text = await CustomDateUtils.timePicker();
      callBack?.call(controller.text);
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

Obx BuildSelectionTextField({
  required List<String> days,
  required Rx<String> dayType,
  String? Function(String?)? vfn,
}) {
  return Obx(
        () =>
        DropdownButtonFormField<String>(
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
                (val) =>
                DropdownMenuItem<String>(
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
