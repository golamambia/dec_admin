import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/signup/controller/signup_controller.dart';
import 'package:decora_admin/signup/service/signup_service.dart';
import 'package:decora_admin/signup/view/UpdatePassword.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';

//ignore: must_be_immutable
class VerifyOtp extends GetView<SignupController> {
  VerifyOtp({Key? key}) : super(key: key);

  // final ApiService p = Get.find<ApiService>();

  final pin = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _signupService = Get.put(SignupService());

  @override
  Widget build(BuildContext context) {
    controller.startTimer();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.bg_1), fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage(ImageAssets.iconPhonePin)),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Text(
                  "Don’t share the is pin code \nSet your  4 digit pin for \nfuture login.",
                  textAlign: TextAlign.center,
                  style: getRFStyle(
                      color: ColorManager.primary, fontSize: FontSize.body),
                ),
              ),
              Text(
                "OTP",
                style: getRFStyle(
                    color: ColorManager.black, fontSize: FontSize.title1),
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                child: PinCodeTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Pin";
                    } else {
                      return null;
                    }
                  },
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
                  // obscuringCharacter: '⬤',
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
                  controller: pin,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],

                  onCompleted: (v) => _lPin(),
                  onChanged: (value) {},
                  beforeTextPaste: (text) => true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(() => controller.isReSend.value==false?Text("${controller.timeDown.value} sec"):SizedBox.shrink()),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () =>  controller.isReSend.value==true
                    ? ElevatedButton(
                        onPressed: () async {
                          controller.startTimer();
                          controller.signup();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            backgroundColor: ColorManager.primary,
                            minimumSize: Size(240.w, 40.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),
                        child: Text(
                          "Re-Send Otp",
                          style: getMFStyle(
                              color: ColorManager.white, fontSize: FontSize.s14),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _lPin() async {
    if (_formKey.currentState!.validate()) {
      bool verifyOpt = await _signupService.verifyOpt(otp: pin.text);
      if (verifyOpt) {
        Get.to(() => UpdatePassword());
      } else {
        Ams.ft("Wrong Otp!!");
      }
    }
  }
}
