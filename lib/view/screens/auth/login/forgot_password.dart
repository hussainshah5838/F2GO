import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:f2g/view/screens/textcontrollers/textcontrollers.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/custom_textfeild_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/custom_button_widget.dart';
import '../get_help.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextControllers textControllers = Get.find<TextControllers>();
  final AuthInputController authInputController =
      Get.find<AuthInputController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
            Positioned(
              top: h(context, 19),
              right: w(context, 19),
              child: SafeArea(
                child: CustomText(
                  onTap: () {
                    Get.to(GetHelpScreen());
                  },
                  text: "Get Help",
                  size: 16,
                  weight: FontWeight.w500,
                  color: kSecondaryColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                  decoration: TextDecoration.underline,
                  decorationColor: kSecondaryColor,
                ),
              ),
            ),
            Padding(
              padding: only(context, top: 80),
              child: Column(
                children: [
                  CommonImageView(
                    imagePath: Assets.imagesApplogo,
                    height: 100,
                    width: 90,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: h(context, 24)),
                  CustomText(
                    text: "Forgot Password",
                    size: 28,
                    weight: FontWeight.w700,
                    lineHeight: h(context, 1),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    paddingBottom: 8,
                  ),
                  CustomText(
                    text:
                        "Please enter the email address that start’s with\nk******@gmail.com",
                    size: 14,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w500,
                    lineHeight: h(context, 1),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: Color(0xff757575),
                    paddingBottom: 24,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(
                            () => CustomTextfeildWidget(
                              index: 5,
                              controller:
                                  textControllers.forgotEmailController.value,
                              suffixicon:
                                  authInputController.isEmailValid.value
                                      ? Assets.imagesRequirementsmetcheck
                                      : Assets.imagesEmail,
                              issuffix: true,
                              onChanged:
                                  (v) => authInputController.onEmailChanged(v),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: symmetric(context, horizontal: 20),
                    child: CustomButton(
                      onPressed: () {
                        if (!authInputController.isEmailValid.value) {
                          displayToast(
                            msg: "Please fill in a valid email address",
                          );
                          return;
                        }
                        // textControllers.forgotEmailController.value,

                        authInputController.restPasswordMethod(
                          email:
                              textControllers.forgotEmailController.value.text
                                  .trim(),
                          widget: Dialog(
                            alignment: Alignment.bottomCenter,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                h(context, 25),
                              ),
                            ),
                            insetPadding: only(
                              context,
                              left: 13,
                              right: 13,
                              bottom: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: h(context, 29)),
                                CommonImageView(
                                  imagePath: Assets.imagesMailsentimage,
                                  height: h(context, 120),
                                  width: w(context, 170),
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: h(context, 19.33)),
                                CustomText(
                                  text: "Mail Sent !",
                                  lineHeight: h(context, 1),
                                  size: 24,
                                  weight: FontWeight.w700,
                                  color: kBlackColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                                SizedBox(height: h(context, 8)),
                                CustomText(
                                  text:
                                      "We have sent an mail on your given email\naddress. Please verify and reset your\npassword.",
                                  size: 16,
                                  weight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  color: const Color(0xff767676),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                                SizedBox(height: h(context, 19.33)),
                                Padding(
                                  padding: symmetric(context, horizontal: 29),
                                  child: CustomButton(
                                    onPressed: () {
                                      textControllers
                                          .forgotEmailController
                                          .value
                                          .clear();
                                      Get.to(() => LoginScreen());
                                    },
                                    // text: "Check mail",
                                    text: "Done",
                                    iscustomgradient: true,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff62D5C3),
                                        Color(0xffD7FAB7),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderradius: 100,
                                    size: 18,
                                    weight: FontWeight.w500,
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                    color: kBlackColor,
                                    height: 46,
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(height: h(context, 20)),
                              ],
                            ),
                          ),
                        );
                      },

                      text: "Send Verification Link",
                      iscustomgradient: true,
                      gradient: LinearGradient(
                        colors: [Color(0xff21E3D7), Color(0xffB5F985)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),

                      borderradius: 100,
                      size: 18,
                      weight: FontWeight.w500,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                      color: kBlackColor,
                      height: 50,
                      width: double.maxFinite,
                    ),
                  ),

                  SizedBox(height: h(context, 16)),
                  SafeArea(
                    top: false,
                    bottom: true,
                    child: RichText(
                      text: TextSpan(
                        text: "Back to ",
                        style: TextStyle(
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          fontSize: f(context, 16),
                          color: Color(0xff757575),
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              fontSize: f(context, 16),
                              color: kSecondaryColor,

                              fontWeight: FontWeight.w500,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAll(LoginScreen());
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h(context, 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
