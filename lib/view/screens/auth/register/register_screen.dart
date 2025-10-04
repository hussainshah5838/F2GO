import 'dart:developer';

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
import 'package:f2g/view/widget/signin_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/custom_button_widget.dart';
import '../get_help.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextControllers textControllers = Get.find<TextControllers>();
  final AuthInputController authInputController = Get.put(
    AuthInputController(),
  );

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
                    text: "Register Now",
                    size: 28,
                    weight: FontWeight.w700,
                    lineHeight: h(context, 1),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    paddingBottom: 8,
                  ),
                  CustomText(
                    text: "Please enter the Information to get started.",
                    size: 14,
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
                              index: 2,
                              hintText: "Full name",
                              controller:
                                  textControllers
                                      .signupFullNameController
                                      .value,
                              suffixicon:
                                  authInputController.isfullnameFilled.value
                                      ? Assets.imagesRequirementsmetcheck
                                      : Assets.imagesFullname,
                              issuffix: true,
                              onChanged:
                                  (v) => authInputController.isFullNameValid(),
                            ),
                          ),
                          SizedBox(height: h(context, 8)),
                          Obx(
                            () => CustomTextfeildWidget(
                              index: 3,
                              controller:
                                  textControllers.signupEmailController.value,
                              suffixicon:
                                  authInputController.isSignupEmailValid.value
                                      ? Assets.imagesRequirementsmetcheck
                                      : Assets.imagesEmail,
                              issuffix: true,
                              onChanged:
                                  (v) => authInputController
                                      .onSignupEmailChanged(v),
                            ),
                          ),
                          SizedBox(height: h(context, 8)),
                          Obx(
                            () => CustomTextfeildWidget(
                              index: 4,
                              hintText: "Create password",
                              obscureText:
                                  authInputController
                                      .issinguppasswordvisible
                                      .value,
                              onTap: () {
                                authInputController
                                    .toggleSignupPasswordVisibility();
                              },
                              issuffix: true,
                              suffixicon:
                                  authInputController
                                          .isSignupPasswordValidRx
                                          .value
                                      ? Assets.imagesRequirementsmetcheck
                                      : Assets.imagesSolideye,
                              // authInputController
                              //     .issinguppasswordvisible
                              //     .value
                              // ? Assets.imagesSolideyedisabled
                              // :  Assets.imagesSolideye,
                              controller:
                                  textControllers
                                      .signuppasswordController
                                      .value,
                              onChanged:
                                  (v) => authInputController
                                      .onSignUpPasswordChanged(v),
                            ),
                          ),
                          SizedBox(height: h(context, 47)),
                          Padding(
                            padding: only(context, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      authInputController.togglePolicyAgree();
                                    },
                                    child: Container(
                                      height: h(context, 22),
                                      width: w(context, 24),
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(
                                          h(context, 8),
                                        ),
                                      ),
                                      child: Center(
                                        child:
                                            authInputController
                                                    .ispolicyagree
                                                    .value
                                                ? Container(
                                                  height: h(context, 12),
                                                  width: w(context, 14),
                                                  decoration: BoxDecoration(
                                                    color: kBlackColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          h(context, 8),
                                                        ),
                                                  ),
                                                )
                                                : null,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: w(context, 8)),
                                RichText(
                                  text: TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      fontSize: f(context, 16),
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                          fontSize: f(context, 16),
                                          color: kSecondaryColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor: kSecondaryColor,

                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.off(LoginScreen());
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h(context, 24)),
                          Obx(
                            () => Padding(
                              padding: symmetric(context, horizontal: 20),
                              child: CustomButton(
                                onPressed: () {
                                  if (authInputController
                                          .isfullnameFilled
                                          .value ==
                                      false) {
                                    displayToast(
                                      msg: "Please fill in your full name",
                                    );
                                    return;
                                  }
                                  if (authInputController
                                          .isSignupEmailValid
                                          .value ==
                                      false) {
                                    displayToast(
                                      msg:
                                          "Please fill in a valid email address",
                                    );
                                    return;
                                  }
                                  if (authInputController
                                          .isSignupPasswordValidRx
                                          .value ==
                                      false) {
                                    displayToast(
                                      msg:
                                          "Please fill in a valid password using numbers and letters",
                                    );
                                    return;
                                  }

                                  if (authInputController.ispolicyagree.value ==
                                      false) {
                                    displayToast(
                                      msg: "Please agree to the Privacy Policy",
                                    );
                                    return;
                                  }

                                  if (authInputController
                                      .areSignupFeildstrue
                                      .value) {
                                    log("------------ Works -----------");

                                    authInputController.signUpMethod(
                                      fullName:
                                          textControllers
                                              .signupFullNameController
                                              .value
                                              .text,

                                      email:
                                          textControllers
                                              .signupEmailController
                                              .value
                                              .text,
                                      password:
                                          textControllers
                                              .signuppasswordController
                                              .value
                                              .text,
                                    );
                                  }
                                },
                                text: "Continue",
                                iscustomgradient: true,
                                gradient:
                                    authInputController
                                            .areSignupFeildstrue
                                            .value
                                        ? LinearGradient(
                                          colors: [
                                            Color(0xff21E3D7),
                                            Color(0xffB5F985),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                        : LinearGradient(
                                          colors: [
                                            Color(
                                              0xff62D5C3,
                                            ).withValues(alpha: 0.5),
                                            Color(
                                              0xffD7FAB7,
                                            ).withValues(alpha: 0.5),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                borderradius: 100,
                                size: 18,
                                weight: FontWeight.w500,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                color:
                                    authInputController
                                            .areSignupFeildstrue
                                            .value
                                        ? kBlackColor
                                        : kBlackColor.withValues(alpha: 0.5),
                                height: 50,
                                width: double.maxFinite,
                              ),
                            ),
                          ),
                          SizedBox(height: h(context, 24)),
                          Padding(
                            padding: symmetric(context, horizontal: 34),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xffE3E3E3),
                                    height: h(context, 1),
                                    thickness: h(context, 1),
                                  ),
                                ),
                                SizedBox(width: w(context, 6.42)),
                                CustomText(
                                  text: "or sign in",
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: Color(0xff767676),
                                ),
                                SizedBox(width: w(context, 6.42)),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xffE3E3E3),
                                    height: h(context, 1),
                                    thickness: h(context, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h(context, 24)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SigninButtons(
                                image: Assets.imagesGooglelogo,
                                onTap: () {},
                              ),
                              SizedBox(width: w(context, 8.54)),
                              SigninButtons(
                                image: Assets.imagesApplelogo,
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: h(context, 24)),
                          RichText(
                            text: TextSpan(
                              text: "Already have an Account? ",
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
                                          Get.off(LoginScreen());
                                        },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
