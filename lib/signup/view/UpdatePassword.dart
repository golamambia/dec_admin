import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:decora_admin/common/view/common_view.dart';
import 'package:decora_admin/login/controller/login_controller.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/date_utils.dart';
// import '../../util/router.dart';
import 'package:decora_admin/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/signup_controller.dart';

class UpdatePassword extends GetView<SignupController> {
  UpdatePassword({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAssets.bg_1), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Signup \nfor the \nnew user!!",
                      style: getBFStyle(
                          color: ColorManager.black, fontSize: FontSize.title1),
                    ),
                    const Image(image: AssetImage(ImageAssets.stdPic))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        _buildAuthTextFormField(
                          controller: controller.newPassword,
                          label: "Password",
                          icon: Icons.school_outlined,
                          vfn: (value) {
                            value = value ?? "";
                            if (value.isEmpty) {
                              return "Field is required for signup";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        _buildAuthTextFormField(
                            controller: controller.confirmPassword,
                            label: "Re-Enter",
                            icon: Icons.phone_android,
                          vfn: (value) {
                            value = value ?? "";
                            if (value.isEmpty) {
                              return "Field is required for signup";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            // _showAwesomeDialog(context);
                            controller.updatePassword();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10.0),
                              backgroundColor: ColorManager.primary,
                              minimumSize: Size(240.w, 40.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          child: Text(
                            "Update Password",
                            style: getMFStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildAuthTextFormField(
      {required TextEditingController controller,
      required String label,
      TextInputType inputType = TextInputType.text,
      String? Function(String?)? vfn,
      bool secure = false,
      required IconData icon}) {
    return TextFormField(
      enabled: true,
      controller: controller,
      obscureText: secure,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text(label,
            style: getMFStyle(
                color: ColorManager.primary, fontSize: FontSize.body)),
        suffixIcon: Icon(icon),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 3)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 3)),
      ),
      maxLines: 1,
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
          ),
      maxLines: minLine,
      // minLines: ,
      validator: vfn,
    );
  }

}
