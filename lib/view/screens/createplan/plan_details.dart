import 'package:f2g/view/screens/createplan/create_new_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../model/plan_model.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_button_widget.dart';

class CreatePlanDetailsScreen extends StatelessWidget {
  CreatePlanDetailsScreen({super.key});

  late final PlanItem planItem = Get.arguments as PlanItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h(context, 8)),
            Row(
              children: [
                SizedBox(width: w(context, 20)),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CommonImageView(
                    imagePath: Assets.imagesGreybackicon,
                    height: 48,
                    width: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 8)),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    planItem.imagePath,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: symmetric(context, horizontal: 20),
                      height: h(context, 375),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(h(context, 25)),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: h(context, 22)),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Padding(
                                      padding: only(context, right: 4),
                                      child: CommonImageView(
                                        imagePath: Assets.imagesStar,
                                        height: 10,
                                        width: 10,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomText(
                                  text: "${planItem.rating} Ratings",
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: Color(0xff2C2C2C),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                              ],
                            ),
                            CustomText(
                              text: planItem.title,
                              size: 24,
                              weight: FontWeight.w500,
                              color: kBlackColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              lineHeight: h(context, 1),
                              paddingBottom: 8,
                              paddingTop: 10,
                            ),
                            Row(
                              children: [
                                CommonImageView(
                                  imagePath: Assets.imagesLocationicon,
                                  height: 18,
                                  width: 18,
                                  fit: BoxFit.contain,
                                ),
                                CustomText(
                                  text: planItem.location,
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor.withValues(alpha: 0.5),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                  paddingLeft: 4,
                                ),
                              ],
                            ),
                            SizedBox(height: h(context, 12)),
                            CustomText(
                              text: planItem.description,
                              size: 14,
                              weight: FontWeight.w500,
                              color: kBlackColor.withValues(alpha: 0.5),
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              lineHeight: h(context, 1.2),
                              paddingBottom: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Opens at",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 4,
                                    ),
                                    CustomText(
                                      text: "10:00 am",
                                      size: 15,
                                      weight: FontWeight.w500,
                                      color: kBlackColor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h(context, 36),
                                  child: VerticalDivider(
                                    color: Color(0xffE3E3E3),
                                    width: w(context, 1),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Ratings",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 4,
                                    ),
                                    CustomText(
                                      text:
                                          "${planItem.rating}(${planItem.reviewCount} reviews)",
                                      size: 15,
                                      weight: FontWeight.w500,
                                      color: kBlackColor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h(context, 36),
                                  child: VerticalDivider(
                                    color: Color(0xffE3E3E3),
                                    width: w(context, 1),
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Loved by",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 4,
                                    ),
                                    CustomText(
                                      text: "500 & more",
                                      size: 15,
                                      weight: FontWeight.w500,
                                      color: kBlackColor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: h(context, 24)),
                            CustomButton(
                              onPressed: () {
                                Get.to(CreateNewPlanScreen());
                              },
                              text: "Create Plan",
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
                              height: 50,
                              width: double.maxFinite,
                            ),
                          ],
                        ),
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
