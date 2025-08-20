import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/dashboard/view/dashboard.dart';
import 'package:decora_admin/login/view/login.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/font_manager.dart';
import '../../../resource/styles_manager.dart';
import '../../dashboard/controller/dashboard_controller.dart';

//ignore: must_be_immutable
class LocalPin extends StatefulWidget {
  LocalPin({Key? key}) : super(key: key);

  @override
  State<LocalPin> createState() => _LocalPinState();
}

class _LocalPinState extends State<LocalPin> {
  // final ApiService p = Get.find<ApiService>();
  final LocalAuthentication auth = LocalAuthentication();

  var loginData = Get.arguments;

  final pin = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (CommonService.localPin.isNotEmpty) fingerprintAuth();
  }

  @override
  Widget build(BuildContext context) {
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
                "PIN",
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
              CommonService.localPin != ""
                  ? ElevatedButton(
                      onPressed: () async {
                        CommonService.saveAllVale();
                        await Get.off(() => LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10.0),
                          backgroundColor: ColorManager.primary,
                          minimumSize: Size(240.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Text(
                        "Reset Pin",
                        style: getMFStyle(
                            color: ColorManager.white, fontSize: FontSize.s14),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  _lPin() async {
    if (_formKey.currentState!.validate()) {
      if (CommonService.localPin.isNotEmpty) {
        if (CommonService.localPin == pin.text) {
          await Get.off(() => Dashboard(),
              binding: BindingsBuilder.put(() => DashboardController()));
        } else {
          Ams.ft("Pin InCorrect");
        }
      } else if (CommonService.localPin.isEmpty) {
        CommonService.saveIndividualValue(
            value: pin.text, type: LocalDataType.localPin);
        Future.delayed(Duration(seconds: 2));
        await Get.off(() => Dashboard(),
            binding: BindingsBuilder.put(() => DashboardController()));
        // Restart.restartApp();
      }
    }
  }

  fingerprintAuth() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: false));
      if (canAuthenticate && didAuthenticate) {
        pin.text = CommonService.localPin;
        _lPin();
      }
    } on PlatformException {
      // if (e.code == auth_error.notAvailable) {
      //   // Add handling of no hardware here.
      // } else if (e.code == auth_error.notEnrolled) {
      //   // ...
      // } else {
      //   // ...
      // }
    }
  }
}
