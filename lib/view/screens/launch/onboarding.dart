import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../../controller/onboardingcontroller.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/custom_button_widget.dart';
import 'image_slider.dart';

class Onboarding extends StatefulWidget {
  Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = Get.put(Onboardingcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
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
                  child: ImageSlider(
                    pageController: controller.pageController,
                    onChange: (index) => controller.onPageChanged(index),
                    currentSlide: controller.currentSlide.value,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Positioned(
            bottom: h(context, 30),
            left: 0,
            right: 0,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: controller.title[controller.currentSlide.value],
                    textAlign: TextAlign.center,
                    color: kWhiteColor,
                    size: 28,
                    lineHeight: h(context, 1),
                    weight: FontWeight.w700,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                  SizedBox(height: h(context, 8)),
                  CustomText(
                    text: controller.detail[controller.currentSlide.value],

                    textAlign: TextAlign.center,
                    color: kPrimaryColor.withValues(alpha: 0.7),
                    size: 14,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                  SizedBox(height: h(context, 24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: symmetric(context, horizontal: 3),
                            width: w(context, 12),
                            height: h(context, 4),
                            decoration: BoxDecoration(
                              color:
                                  controller.currentSlide.value == index
                                      ? kWhiteColor
                                      : kWhiteColor.withValues(alpha: 0.25),

                              borderRadius: BorderRadius.circular(
                                h(context, 100),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 24)),
                  Padding(
                    padding: symmetric(context, horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('key', true);
                              Get.offAll(() => LoginScreen());
                            },
                            text: "Skip",
                            backgroundcolor: kWhiteColor.withValues(
                              alpha: 0.12,
                            ),
                            isborder: true,
                            bordercolor: kWhiteColor.withValues(alpha: 0.08),
                            borderradius: 100,
                            size: 18,
                            weight: FontWeight.w500,
                            fontFamily: AppFonts.Satoshi,
                            color: kWhiteColor,
                            height: 50,
                          ),
                        ),
                        SizedBox(width: w(context, 8)),
                        Expanded(
                          child: CustomButton(
                            onPressed: controller.nextSlide,
                            text: "Next",
                            iscustomgradient: false,
                            borderradius: 100,
                            size: 18,
                            weight: FontWeight.w500,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            color: kBlackColor,
                            height: 50,
                            width: 190,
                          ),
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
    );
  }
}
