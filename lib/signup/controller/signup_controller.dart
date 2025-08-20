import 'dart:async';

import 'package:decora_admin/login/view/login.dart';
import 'package:decora_admin/signup/model/signup_model.dart';
import 'package:decora_admin/signup/service/signup_service.dart';
import 'package:decora_admin/signup/view/VerifyOtp.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var schoolCode = TextEditingController();
  var mobileNo = TextEditingController();
  var date = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  SignupModel? signupModel = SignupModel();

  final SignupService _signupService = Get.put(SignupService());

  var timeDown = 120.obs;
  var isReSend = false.obs;
  var isSignup = true;

  late Timer _timer;

  void startTimer() {
    isReSend.value = false;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeDown.value > 0) {
          Get.log("timer: ${timeDown.value}");
          timeDown.value--; // Correct way to decrement the observable
        } else {
          timeDown.value = 120;
          isReSend.value = true;
          timer.cancel();
        }
      },
    );
  }

  void signup() async {
    if (formKey.currentState!.validate()) {
      var status = isSignup
          ? await _signupService.postSignup(
              schoolCode: schoolCode.text,
              mobile: mobileNo.text,
              dob: date.text)
          : await _signupService.forgetPassword(
              schoolCode: schoolCode.text,
              mobile: mobileNo.text,
              dob: date.text);
      if (status == true) {
        Get.to(() => VerifyOtp());
      }
    }
  }

  void updatePassword() async {
    if (formKey.currentState!.validate()) {
      if (newPassword.text != confirmPassword.text) {
        Ams.ft("password not matched!!");
        return;
      }
      var status = await _signupService.updatePassword(
        passCode: newPassword.text,
      );
      if (status) {
        Ams.ft("password set successfully.");
        Get.offAll(() => LoginPage());
      } else {
        Ams.ft("please try later!!!");
      }
    }
  }
}
