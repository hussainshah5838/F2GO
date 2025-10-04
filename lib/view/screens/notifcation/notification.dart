import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final _controller = Get.put(NotificationController());

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
                  SizedBox(height: h(context, 19)),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();

                          // for testing
                          Get.delete<NotificationController>();
                        },
                        child: CommonImageView(
                          imagePath: Assets.imagesMenu,
                          height: 48,
                          width: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: w(context, 15)),
                      CustomText(
                        text: "Notifications",
                        size: 20,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 22)),
                  Expanded(
                    child: Obx(
                      () =>
                          _controller.notifications.isEmpty
                              ? _buildEmptyWidget(context)
                              : _buildNotificationList(context),
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

  Widget _buildEmptyWidget(BuildContext context) {
    return Padding(
      padding: only(context, bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImageView(
            imagePath: Assets.imagesNotificationbell,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          SizedBox(height: h(context, 16)),
          CustomText(
            text: "No Notifications Yet!",
            size: 20,
            weight: FontWeight.w700,
            color: kBlackColor,
            fontFamily: AppFonts.HelveticaNowDisplay,
            paddingBottom: 4,
          ),
          CustomText(
            text: "No Notifications to be shown yet.",
            size: 16,
            weight: FontWeight.w500,
            color: ktextcolor,
            fontFamily: AppFonts.HelveticaNowDisplay,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return ListView.separated(
      itemCount: _controller.notifications.length,
      separatorBuilder: (_, __) => SizedBox(height: h(context, 10)),
      itemBuilder: (_, index) {
        final item = _controller.notifications[index];
        return Container(
          padding: all(context, 14),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(h(context, 12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: item.title,
                      size: 16,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ),
                  SizedBox(width: w(context, 10)),
                  CustomText(
                    text: item.time,
                    size: 12,
                    weight: FontWeight.w500,
                    color: ktextcolor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                ],
              ),
              SizedBox(height: h(context, 5)),
              CustomText(
                text: item.subText,
                size: 12,
                weight: FontWeight.w500,
                color: ktextcolor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
            ],
          ),
        );
      },
    );
  }
}
