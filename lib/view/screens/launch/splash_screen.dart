import 'dart:async';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:f2g/view/screens/launch/onboarding.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/app_images.dart';
import '../../widget/common_image_view_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  // void _navigateToNextScreen() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     Get.offAll(() => Onboarding(), binding: AuthBindings());
  //   });
  // }

  void splashScreenHandler() async {
    final prefs = await SharedPreferences.getInstance();
    bool key = prefs.getBool('key') ?? false;

    Timer(Duration(seconds: 3), () {
      if (auth.currentUser != null) {
        Get.offAll(() => HomeScreen());
      } else {
        if (key == true) {
          Get.offAll(() => LoginScreen());
        } else {
          Get.offAll(() => Onboarding());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: OverflowBox(
                  alignment: Alignment.center,
                  minWidth: constraints.maxWidth * 1.02,
                  minHeight: constraints.maxHeight * 1.02,
                  maxWidth: constraints.maxWidth * 1.02,
                  maxHeight: constraints.maxHeight * 1.02,
                  child: CommonImageView(
                    imagePath: Assets.imagesSplashScreenbackground,
                  ),
                ),
              );
            },
          ),

          CommonImageView(
            imagePath: Assets.imagesSplashlogo,
            height: 309,
            width: 206,
            fit: BoxFit.contain,
          ),
          Positioned(
            bottom: h(context, 17),
            child: SafeArea(
              bottom: true,
              child: CustomText(
                text: "Powered by Friends2go",
                size: 16,
                weight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
