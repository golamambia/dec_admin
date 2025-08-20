import 'package:decora_admin/localPin/controller/pin_controller.dart';
import 'package:decora_admin/splash/SplashPage.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';

class ChangePin extends StatelessWidget {
  ChangePin({Key? key}) : super(key: key);


  var _pinController = Get.put<PinController>(PinController());


  String currentPin =
  getStringAsync("localPin").isNotEmpty ? getStringAsync("localPin") : "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Change Pin",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _pinController.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    _PinCodeField(
                        context: context,
                        label: "Current Pin",
                        validator: _pinController.oldPinValidation,
                        controller: _pinController.oldPin,
                        subText:"(if you don't have old pin please leave this filed)"
                    ),
                    _PinCodeField(
                        context: context,
                        label: "New Pin",
                        controller: _pinController.newPin,
                        validator: _pinController.newPinValidation
                    ),
                    _PinCodeField(
                        context: context,
                        label: "New Pin Again",
                        controller: _pinController.rePin,
                        validator: _pinController.checkPinValidation),
                    SizedBox(height: 14.0),
                    ElevatedButton.icon(
                        onPressed: _pinController.submit,
                        icon: const Icon(Icons.lock_reset_outlined),
                        label: const Text("Save"))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

Widget _PinCodeField({required BuildContext context,
  required String label,
  String? subText,
  required TextEditingController? controller,
  String? Function(String?)? validator
}) {
  return Column(
    children: [
      Text(
        label,
        style: getMFStyle(color: ColorManager.black, fontSize: FontSize.title1),
      ),
      subText != null ? Text(
        subText,
        style: getRFStyle(
            color: ColorManager.black, fontSize: FontSize.caption),
      ) : SizedBox.shrink(),

      const SizedBox(height: 10),
      PinCodeTextField(
        validator: validator,
        enablePinAutofill: true,
        autoDismissKeyboard: true,
        autoDisposeControllers: true,
        autoFocus: true,
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        obscureText: true,
        obscuringCharacter: '*',
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 70.h,
          fieldWidth: 70.w,
          activeFillColor: ColorManager.primaryMedium,
          activeColor: ColorManager.primary,
          selectedFillColor: ColorManager.primaryLight,
          selectedColor: Colors.transparent,
          inactiveColor: Colors.transparent,
          inactiveFillColor: ColorManager.primaryLight,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: FontSize.h1,
            fontWeight: FontWeight.normal,
            height: 2.0,
            color: ColorManager.black),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: controller,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],

        // onCompleted: (v) => _lPin(),
        // onChanged: (value) {},
        beforeTextPaste: (text) => true,
      ),
    ],
  );
}
