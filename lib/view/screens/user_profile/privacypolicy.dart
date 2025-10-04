import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_images.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: h(context, 20)),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: CommonImageView(
                          imagePath: Assets.imagesBackicon,
                          height: 48,
                          width: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: w(context, 15)),
                      CustomText(
                        text: "Privacy Policy",
                        size: 16,
                        weight: FontWeight.w500,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                        color: kBlackColor,
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 20)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Introduction",
                            size: 18,
                            weight: FontWeight.w700,
                            paddingBottom: 8,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                            size: 14,
                            weight: FontWeight.w500,
                            paddingBottom: 12,
                            color: kBlackColor.withValues(alpha: 0.6),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            text: "Introduction",
                            size: 18,
                            weight: FontWeight.w700,
                            paddingBottom: 8,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                            size: 14,
                            weight: FontWeight.w500,
                            paddingBottom: 12,
                            color: kBlackColor.withValues(alpha: 0.6),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                            size: 14,
                            weight: FontWeight.w500,
                            paddingBottom: 12,
                            color: kBlackColor.withValues(alpha: 0.6),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                            size: 14,
                            weight: FontWeight.w500,
                            paddingBottom: 12,
                            color: kBlackColor.withValues(alpha: 0.6),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ],
                      ),
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
