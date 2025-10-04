import 'package:f2g/view/screens/auth/get_help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_styling.dart';
import '../../../../controller/otpcontroller.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/custom_button_widget.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final OtpController controller = Get.put(OtpController());

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
                    text: "Verification Code",
                    size: 28,
                    weight: FontWeight.w700,
                    lineHeight: h(context, 1),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    paddingBottom: 8,
                  ),
                  CustomText(
                    text:
                        "We have sent a verification code on your email\naddress chri******@gmail.com",
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
                          Padding(
                            padding: symmetric(context, horizontal: 30.71),
                            child: SizedBox(
                              width: w(context, double.maxFinite),
                              child: Pinput(
                                length: 5,
                                onChanged:
                                    (val) => controller.onOtpChanged(val),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                submittedPinTheme: PinTheme(
                                  textStyle: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: f(context, 30),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),
                                  height: h(context, 58),
                                  width: w(context, 54),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      h(context, 10.89),
                                    ),
                                    color: kSecondaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    border: Border.all(
                                      color: kSecondaryColor,
                                      width: w(context, 1.09),
                                    ),
                                  ),
                                ),
                                focusedPinTheme: PinTheme(
                                  textStyle: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: f(context, 30),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),
                                  height: h(context, 58),
                                  width: w(context, 54),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      h(context, 10.89),
                                    ),
                                    color: kSecondaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    border: Border.all(
                                      color: kSecondaryColor,
                                      width: w(context, 1.09),
                                    ),
                                  ),
                                ),
                                defaultPinTheme: PinTheme(
                                  textStyle: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: f(context, 30),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),
                                  height: h(context, 58),
                                  width: w(context, 54),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      h(context, 10.89),
                                    ),
                                    color: kWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.ResendText.value == "Resend OTP") {
                          controller.resetTimer();
                        }
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn't receive code? ",
                              style: TextStyle(
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                fontSize: f(context, 16),
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text:
                                  controller.ResendText.value == "Resend OTP"
                                      ? "Resend OTP"
                                      : controller.formattedTime,
                              style: TextStyle(
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                fontSize: f(context, 16),
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(context, 16)),
                  SafeArea(
                    bottom: true,
                    top: false,
                    child: Obx(
                      () => Padding(
                        padding: symmetric(context, horizontal: 20),
                        child: CustomButton(
                          onPressed:
                              controller.isOtpFilled.value
                                  ? () => controller.onConfirmPressed(context)
                                  : null,

                          text: "Continue",
                          iscustomgradient: true,
                          gradient:
                              controller.isOtpFilled.value
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
                                      Color(0xff62D5C3).withValues(alpha: 0.5),
                                      Color(0xffD7FAB7).withValues(alpha: 0.5),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),

                          borderradius: 100,
                          size: 18,
                          weight: FontWeight.w500,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          color:
                              controller.isOtpFilled.value
                                  ? kBlackColor
                                  : kBlackColor.withValues(alpha: 0.5),
                          height: 50,
                          width: double.maxFinite,
                        ),
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
