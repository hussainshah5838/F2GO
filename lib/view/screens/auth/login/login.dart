import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/view/screens/auth/login/forgot_password.dart';
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
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                    text: "Welcome Back!",
                    size: 28,
                    weight: FontWeight.w700,
                    lineHeight: h(context, 1),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    paddingBottom: 8,
                  ),
                  CustomText(
                    text: "Please enter the credentials to get started.",
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
                              index: 0,
                              controller:
                                  textControllers.signinEmailController.value,
                              suffixicon:
                                  authInputController.isEmailValid.value
                                      ? Assets.imagesRequirementsmetcheck
                                      : Assets.imagesEmail,
                              issuffix: true,
                              onChanged:
                                  (v) => authInputController.onEmailChanged(v),
                            ),
                          ),
                          SizedBox(height: h(context, 8)),
                          Obx(
                            () => CustomTextfeildWidget(
                              index: 1,
                              hintText: "Password",
                              obscureText:
                                  authInputController
                                      .isloginpasswordvisible
                                      .value,
                              onTap: () {
                                authInputController
                                    .toggleLoginPasswordVisibility();
                              },
                              issuffix: true,
                              suffixicon:
                                  authInputController
                                          .isloginpasswordvisible
                                          .value
                                      ? Assets.imagesSolideye
                                      : Assets.imagesSolideyedisabled,
                              controller:
                                  textControllers
                                      .signinpasswordController
                                      .value,
                              onChanged:
                                  (v) =>
                                      authInputController.onPasswordChanged(v),
                              errorBorder:
                                  authInputController.isPasswordError.value,
                            ),
                          ),
                          SizedBox(height: h(context, 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: w(context, 20)),
                              Obx(
                                () =>
                                    authInputController.isPasswordError.value
                                        ? Row(
                                          children: [
                                            CommonImageView(
                                              imagePath:
                                                  Assets.imagesInfocircle,
                                              height: 18,
                                              width: 18,
                                            ),
                                            SizedBox(width: w(context, 4)),
                                            CustomText(
                                              text: "Invalid Password",
                                              size: 16,
                                              weight: FontWeight.w500,
                                              color: Color(0xffEA4335),
                                              fontFamily:
                                                  AppFonts.HelveticaNowDisplay,
                                            ),
                                          ],
                                        )
                                        : SizedBox.shrink(),
                              ),
                              Spacer(),

                              CustomText(
                                paddingRight: 20,
                                onTap: () {
                                  Get.to(ForgotPasswordScreen());
                                },
                                text: "Forgot Password?",
                                size: 16,
                                weight: FontWeight.w500,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                color: kSecondaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: h(context, 46)),
                          Padding(
                            padding: only(context, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      authInputController.toggleRememberMe();
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
                                                    .isrememberme
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
                                CustomText(
                                  text: "Remember me",
                                  size: 16,
                                  weight: FontWeight.w500,
                                  color: kBlackColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
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
                                  // authInputController.isPasswordError.value =
                                  true;
                                  if (!authInputController.isEmailValid.value) {
                                    displayToast(
                                      msg:
                                          "Please fill in a valid email address",
                                    );
                                    return;
                                  }

                                  if (textControllers
                                      .signinpasswordController
                                      .value
                                      .text
                                      .isEmpty) {
                                    displayToast(
                                      msg: "Please fill in a valid password",
                                    );
                                    return;
                                  }

                                  authInputController.signInMethod(
                                    textControllers
                                        .signinEmailController
                                        .value
                                        .text
                                        .trim()
                                        .toString(),
                                    textControllers
                                        .signinpasswordController
                                        .value
                                        .text
                                        .trim()
                                        .toString(),
                                  );

                                  // authInputController.areFieldsFilled.value
                                  //     ? authInputController.validatePassword()
                                  //     : null;
                                },
                                text: "Continue",
                                iscustomgradient: true,
                                gradient:
                                    authInputController.areFieldsFilled.value
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
                                    authInputController.areFieldsFilled.value
                                        ? kBlackColor
                                        : kBlackColor.withValues(alpha: 0.5),
                                height: 50,
                                width: double.maxFinite,
                              ),
                            ),
                          ),
                          SizedBox(height: h(context, 20)),
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
                          SizedBox(height: h(context, 20)),
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
                          SizedBox(height: h(context, 20)),
                          RichText(
                            text: TextSpan(
                              text: "Don’t have an Account? ",
                              style: TextStyle(
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                fontSize: f(context, 16),
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                    fontSize: f(context, 16),
                                    color: kSecondaryColor,

                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.off(RegisterScreen());
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
