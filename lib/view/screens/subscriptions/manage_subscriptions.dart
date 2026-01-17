import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/screens/launch/splash_screen.dart';
import 'package:f2g/view/widget/Common_image_view_widget.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSubscriptionsScreen extends StatelessWidget {
  const ManageSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesProfilebg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h(context, 16)),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(width: w(context, 12)),
                      CustomText(
                        text: "Manage Subscriptions",
                        size: 16,
                        weight: FontWeight.w600,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 18)),
                  _buildPlanCard(context),
                  SizedBox(height: h(context, 16)),
                  CustomText(
                    text: "PAYMENT METHODS",
                    size: 12,
                    weight: FontWeight.w500,
                    color: ktextcolor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    paddingBottom: 10,
                  ),
                  _buildPaymentMethodCard(context),
                  const Spacer(),
                  CustomButton(
                    onPressed: () {
                      Get.offAll(() => SplashScreen());
                    },
                    text: "Add new payment method",
                    borderradius: 100,
                    size: 18,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    height: 50,
                    width: double.maxFinite,
                  ),
                  SizedBox(height: h(context, 14)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context) {
    const double usedDays = 1;
    const double totalDays = 3;
    final double progress = usedDays / totalDays;

    return Container(
      padding: all(context, 14),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 16)),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: all(context, 10),
                decoration: BoxDecoration(
                  color: const Color(0xffE2F8F4),
                  shape: BoxShape.circle,
                ),
                child: CommonImageView(
                  imagePath: Assets.imagesLimitedPlan,
                  height: 30,
                  width: 30,
                  color: kSecondaryColor,
                ),
              ),
              SizedBox(width: w(context, 10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Basic Plan",
                                size: 16,
                                weight: FontWeight.w700,
                                color: kBlackColor,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                              ),
                              CustomText(
                                text: "Your free trial will expire in 2 days.",
                                size: 13,
                                weight: FontWeight.w500,
                                color: ktextcolor,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w(context, 10),
                            vertical: h(context, 4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              h(context, 100),
                            ),
                          ),
                          child: CustomText(
                            text: "Active",
                            size: 12,
                            weight: FontWeight.w600,
                            color: Colors.green,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: h(context, 6)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h(context, 14)),
          Container(
            height: h(context, 6),
            decoration: BoxDecoration(
              color: kBlackColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(h(context, 10)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
              ),
            ),
          ),
          SizedBox(height: h(context, 8)),
          Row(
            children: [
              CustomText(
                text: "Subscribed : May 23, 2025",
                size: 12,
                weight: FontWeight.w500,
                color: ktextcolor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
              const Spacer(),
              CustomText(
                text:
                    "${usedDays.toStringAsFixed(0)} / ${totalDays.toStringAsFixed(0)} days used",
                size: 12,
                weight: FontWeight.w500,
                color: ktextcolor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
            ],
          ),
          SizedBox(height: h(context, 14)),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "Cancel",
                  iscustomgradient: true,
                  gradient: LinearGradient(
                    colors: [
                      kBlackColor.withValues(alpha: 0.05),
                      kBlackColor.withValues(alpha: 0.05),
                    ],
                  ),
                  borderradius: 100,
                  size: 16,
                  weight: FontWeight.w600,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                  color: kBlackColor,
                  height: 46,
                ),
              ),
              SizedBox(width: w(context, 10)),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "Upgrade",
                  iscustomgradient: true,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 184, 239, 246),
                      Color.fromARGB(255, 184, 239, 246),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderradius: 100,
                  size: 16,
                  weight: FontWeight.w600,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                  color: kSecondaryColor,
                  height: 46,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: all(context, 14),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Mastercard ***56",
                  size: 14,
                  weight: FontWeight.w700,
                  color: kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
                SizedBox(height: h(context, 6)),
                CustomText(
                  text: "Expiry date: 05/29",
                  size: 12,
                  weight: FontWeight.w500,
                  color: ktextcolor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ],
            ),
          ),
          _circleIconButton(
            context,
            icon: Icons.delete_outline,
            color: const Color(0xffFFE7E7),
            iconColor: const Color(0xffDF5A5A),
            onTap: () {},
          ),
          SizedBox(width: w(context, 8)),
          _circleIconButton(
            context,
            icon: Icons.edit,
            color: const Color(0xffE7F6FF),
            iconColor: const Color(0xff4A90E2),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: all(context, 8),

        decoration: BoxDecoration(
          color: color,

          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
