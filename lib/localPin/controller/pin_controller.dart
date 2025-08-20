import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/splash/SplashPage.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PinController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController oldPin = TextEditingController();
  final TextEditingController newPin = TextEditingController();
  final TextEditingController rePin = TextEditingController();
  var currentPin = CommonService.localPin;

  String? oldPinValidation(String? value) {
    if (currentPin.isNotEmpty&&value == null && value!.isEmpty) {
      return "Please enter the passCode";
    } else if (currentPin.isNotEmpty&&oldPin.text != currentPin) {
      return "Invalid old pin";
    }
    return null;
  }

  String? newPinValidation(String? value) {
    if (value == null && value!.isEmpty) {
      return "Please enter the passCode";
    }
    return null;
  }

  String? checkPinValidation(String? value) {
    if (value == null && value!.isEmpty) {
      return "please enter the passCode";
    } else if (newPin.text != rePin.text) {
      return "New Pin does not matching";
    }
    return null;
  }

  void submit() async {
    if(currentPin.isEmpty){
      _showAwesomeDialog();
    }
    if (formKey.currentState!.validate()) {
      CommonService.saveIndividualValue(
          value: newPin.text, type: LocalDataType.localPin);
      Get.offAll(() => SplashPage());
    }
  }

  void _showAwesomeDialog() {
    var context = Get.context!;
    Ams.dialogFail(
      context: context,
      title: "Successful",
      message: "you does not set any pin while login, please ",
    ).show();
  }
}
