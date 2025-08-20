import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:decora_admin/login/controller/login_controller.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/signup/controller/signup_controller.dart';
import 'package:decora_admin/signup/service/signup_service.dart';
import 'package:decora_admin/signup/view/VerifyOtp.dart';
import 'package:decora_admin/signup/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final loginController = Get.put(LoginController());
  final SignupController _signupController = Get.put(SignupController());


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
                      "Already \nhave an \nAccount?",
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
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        _buildAuthTextFormField(
                          controller: loginController.schoolCode,
                          label: "School Code",
                          icon: Icons.school_outlined,
                          vfn: (value) {
                            value = value ?? "";
                            if (value.isEmpty) {
                              return "Field is required for login";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        _buildAuthTextFormField(
                            controller: loginController.mobileNo,
                            label: "Mobile No.",
                            inputType: TextInputType.phone,
                            icon: Icons.phone_android,
                          vfn: (value) {
                            value = value ?? "";
                            if (value.isEmpty) {
                              return "Field is required for login";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        _buildAuthTextFormField(
                            controller: loginController.password,
                            label: "Password",
                            secure: true,
                            icon: Icons.lock_outline,
                          vfn: (value) {
                            if (value!.isEmpty) {
                              return "Field is required for login";
                            }
                            return null;
                          },),
                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: ColorManager.primary))
                              ),
                              child: InkWell(
                                  onTap: () {
                                    _signupController.isSignup=false;
                                    Get.to(()=>SignupPage(),binding: BindingsBuilder.put(()=>SignupController()));

                                  },
                                  child: Text("Forget Password",style: getMFStyle(color: ColorManager.primary, fontSize: FontSize.s14),)),
                            ),
                          ],
                        ),


                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            // _showAwesomeDialog(context);
                            loginController.login();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10.0),
                              backgroundColor: ColorManager.primary,
                              minimumSize: Size(240.w, 40.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          child: Text(
                            "Login",
                            style: getMFStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New user? ",style: getRFStyle(color: ColorManager.greyMedium, fontSize: FontSize.s14)),
                            InkWell(
                              onTap: () {
                                _signupController.isSignup=true;
                                Get.to(()=>SignupPage(),binding: BindingsBuilder.put(()=>SignupController()));
                              },
                                child: Text("signup",style: getMFStyle(color: ColorManager.primary, fontSize: FontSize.s14),)),
                          ],
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

}
