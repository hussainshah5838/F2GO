import 'dart:async';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';
import '../constants/app_images.dart';
import '../constants/app_styling.dart';
import '../view/widget/Custom_text_widget.dart';
import '../view/widget/common_image_view_widget.dart';
import '../view/widget/custom_button_widget.dart';

class OtpController extends GetxController {
  RxInt timer = 60.obs;
  RxString ResendText = "Didn't receive code? ".obs;

  late Timer _countdownTimer;

  var otpValue = "".obs;
  var isOtpFilled = false.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  String get formattedTime {
    final int minutes = timer.value ~/ 60;
    final int seconds = timer.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void onOtpChanged(String value) {
    otpValue.value = value;
    isOtpFilled.value = value.length == 5;
  }

  void startTimer() {
    ResendText.value = "Didn't receive code? ";
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        ResendText.value = "Resend OTP";
      }
    });
  }

  void resetTimer() {
    _countdownTimer.cancel();
    timer.value = 60;
    ResendText.value = "Resend OTP";
    startTimer();
  }

  void onConfirmPressed(BuildContext context) {
    _countdownTimer.cancel();
    ResendText.value = "Didn't receive code? ";
    timer.value = 60;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(h(context, 25)),
          ),
          insetPadding: only(context, left: 13, right: 13, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: h(context, 29)),
              CommonImageView(
                imagePath: Assets.imagesAccountcreatedimage,
                height: h(context, 120),
                width: w(context, 170),
                fit: BoxFit.contain,
              ),
              SizedBox(height: h(context, 19.33)),
              CustomText(
                text: "Account Created!",
                lineHeight: h(context, 1),
                size: 24,
                weight: FontWeight.w700,
                color: kBlackColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text:
                    "You have successfully created your\naccount. Enjoy the ride",
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
                    Get.offAll(HomeScreen());
                  },
                  text: "Go the Home Page",
                  iscustomgradient: true,
                  gradient: const LinearGradient(
                    colors: [Color(0xff21E3D7), Color(0xffB5F985)],
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
        );
      },
    );
  }

  @override
  void onClose() {
    _countdownTimer.cancel();
    super.onClose();
  }
}
