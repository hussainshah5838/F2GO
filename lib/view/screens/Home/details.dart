import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_button_widget.dart';

class DetailsController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final _controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: h(context, 8)),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Container(
                    height: h(context, 48),
                    width: w(context, 48),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CommonImageView(
                        imagePath: Assets.imagesHeart,
                        height: 18,
                        width: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h(context, 8)),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: h(context, 340),
                        child: PageView.builder(
                          controller: _controller.pageController,
                          itemCount: 3,
                          onPageChanged: _controller.onPageChanged,
                          itemBuilder: (_, __) {
                            return Image.asset(
                              Assets.imagesDetailsimage,
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                            );
                          },
                        ),
                      ),
                      Obx(
                        () => Positioned(
                          bottom: h(context, 67),
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Container(
                                margin: symmetric(
                                  context,
                                  horizontal: w(context, 1),
                                ),
                                height: h(context, 8),
                                width: w(context, 28),
                                decoration: BoxDecoration(
                                  color: _controller.currentIndex.value == index
                                      ? kPrimaryColor
                                      : kPrimaryColor.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(
                                    h(context, 100),
                                  ),
                                  border: Border.all(
                                    color:
                                        _controller.currentIndex.value == index
                                        ? Colors.transparent
                                        : kPrimaryColor.withValues(alpha: 0.36),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            CustomText(
                              text: "Painting Fun",
                              size: 24,
                              weight: FontWeight.w500,
                              color: kBlackColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              lineHeight: h(context, 1),
                              paddingBottom: 8,
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
                                  text: "Wilson Park , United States",
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor.withValues(alpha: 0.5),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                  paddingLeft: 4,
                                ),
                              ],
                            ),
                            SizedBox(height: h(context, 13)),
                            CustomText(
                              text:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
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
                                      text: "Date & Time",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 4,
                                    ),
                                    CustomText(
                                      text: "10:00 am | Jun 23, 2025",
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
                                      text: "Participants",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 4,
                                    ),
                                    CustomText(
                                      text: "6/10 members joined",
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
                            SizedBox(height: h(context, 50)),
                            CustomButton(
                              onPressed: () {},
                              text: "Join",
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
