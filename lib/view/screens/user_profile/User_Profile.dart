import 'dart:developer';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/editprofile_controller.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/view/widget/custom_switch.dart';
import 'package:f2g/view/widget/custom_textfeild_widget.dart';
import 'package:flutter/material.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/Common_image_view_widget.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/custom_button_widget.dart';
import 'change_password.dart';
import 'edit_profile.dart';
import 'feedback.dart';
import 'privacypolicy.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  void _show_deleteAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(h(context, 24)),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            bottom: h(context, 20),
            left: w(context, 13),
            right: w(context, 13),
          ),
          padding: only(context, top: 29, bottom: 29),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(h(context, 25))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CommonImageView(
                  imagePath: Assets.imagesDustbin,
                  height: 120,
                  width: 170,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: h(context, 19.33)),

              CustomText(
                text: "Delete Account?",
                size: 24,
                weight: FontWeight.w700,
                color: kBlackColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text:
                    "Are you sure you want to delete your\naccount. This will erase all your\ncurrent data.",
                size: 16,
                color: ktextcolor,
                fontFamily: AppFonts.HelveticaNowDisplay,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h(context, 19.33)),
              Padding(
                padding: symmetric(context, horizontal: 29),
                child: CustomButton(
                  onPressed: () {
                    log("Delete Account Tapped");
                    showDeleteConfirmationDialog(
                      onDeleteTap: () {
                        if (Get.find<ProfileController>()
                            .accountDeletionPasswordController
                            .text
                            .isEmpty) {
                          displayToast(msg: "Please enter your password");
                          return;
                        }

                        Get.find<ProfileController>().deleteCurrentUserAccount(
                          context,
                        );
                      },
                      onCancelTap: () {
                        Get.back();
                      },
                    );

                    // Navigator.pop(context);
                  },
                  text: "Yes, Delete",
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
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(h(context, 25)),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            bottom: h(context, 20),
            left: w(context, 13),
            right: w(context, 13),
          ),
          padding: only(context, top: 29, bottom: 29),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(h(context, 25))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CommonImageView(
                  imagePath: Assets.imagesLogoutpop,
                  height: 120,
                  width: 170,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: h(context, 19.33)),

              CustomText(
                text: "Logout",
                size: 24,
                weight: FontWeight.w700,
                color: kBlackColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text: "Are you sure you want to logout from\nthis app?",
                size: 16,
                color: ktextcolor,
                fontFamily: AppFonts.HelveticaNowDisplay,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h(context, 19.33)),
              Padding(
                padding: symmetric(context, horizontal: 29),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Yes, Logout",
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
              ),
            ],
          ),
        );
      },
    );
  }

  ProfileController _ctrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: h(context, 20)),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CommonImageView(
                        imagePath: Assets.imagesMenu,
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: w(context, 16)),
                    Expanded(
                      child: CustomText(
                        text: "User Profile",
                        size: 20,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h(context, 20)),

                Container(
                  padding: symmetric(context, horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h(context, 12)),
                    color: kTertiaryColor,
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            (userService.userModel.value.profileImage != null)
                                ? CommonImageView(
                                  url: userService.userModel.value.profileImage,
                                  height: 40,
                                  width: 40,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                )
                                : CommonImageView(
                                  imagePath: Assets.imagesProfilepic,
                                  height: 40,
                                  width: 40,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                ),

                            SizedBox(width: w(context, 6)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        userService.userModel.value.fullName ??
                                        "",
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: kBlackColor,
                                    lineHeight: h(context, 1),
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),
                                  SizedBox(height: h(context, 6)),
                                  CustomText(
                                    text:
                                        userService.userModel.value.email ?? "",
                                    size: 14,
                                    lineHeight: h(context, 1),
                                    color: kBlackColor.withValues(alpha: 0.6),
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h(context, 16)),

                      InkWell(
                        onTap: () {
                          Get.to(EditProfileScreen());
                        },
                        child: Container(
                          height: h(context, 38),
                          width: double.infinity,
                          padding: symmetric(context, horizontal: 14),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(h(context, 12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Edit Profile",
                                size: 14,
                                weight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                letterSpacing: w(context, -0.41),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => EditProfileScreen());
                                },
                                child: CommonImageView(
                                  imagePath: Assets.imagesVector,
                                  height: 10,
                                  width: 6,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h(context, 16)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "GENERAL SETTINGS",
                          size: 12,
                          weight: FontWeight.w500,
                          color: ktextcolor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildSettingTile(
                          context,
                          iconPath: Assets.imagesKey,
                          title: "Change Password",
                          onTap: () {
                            Get.to(() => ChangePasswordScreen());
                          },
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildNotificationTile(context),

                        SizedBox(height: h(context, 16)),

                        CustomText(
                          text: "HELP & SUPPORT",
                          size: 12,
                          weight: FontWeight.w500,
                          color: ktextcolor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildSettingTile(
                          context,
                          iconPath: Assets.imagesFeedback,
                          title: "App Feedback",
                          onTap: () {
                            Get.to(() => AppFeedbackScreen());
                          },
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildSettingTile(
                          context,
                          iconPath: Assets.imagesPrivacy,
                          title: "Privacy Policy",
                          onTap: () {
                            Get.to(() => PrivacyPolicyScreen());
                          },
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildSettingTile(
                          context,
                          iconPath: Assets.imagesLogout,
                          title: "Logout",
                          onTap: () {
                            _showLogoutSheet(context);
                          },
                        ),
                        SizedBox(height: h(context, 8)),

                        _buildSettingTile(
                          context,
                          iconPath: Assets.imagesDelete,
                          imagebg: Color(0xffEA4335).withValues(alpha: 0.1),
                          title: "Delete Account",
                          textColor: Color(0xffEA4335),
                          onTap: () {
                            _show_deleteAccountSheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black,
    Color? imagebg,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: symmetric(context, vertical: 8, horizontal: 12),
        width: w(context, double.maxFinite),
        decoration: BoxDecoration(
          color: kWhiteColor,

          // borderRadius: BorderRadiusGeometry.circular(h(context, 12)),
        ),
        child: Row(
          children: [
            Container(
              height: h(context, 36),
              width: w(context, 36),
              decoration: BoxDecoration(
                color: imagebg ?? kSecondaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CommonImageView(
                  imagePath: iconPath,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: w(context, 8)),
            Expanded(
              child: CustomText(
                text: title,
                size: 16,
                weight: FontWeight.w500,
                color: textColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
            ),
            CommonImageView(
              imagePath: Assets.imagesVector,
              height: 12,
              width: 8,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: ListTile(
        horizontalTitleGap: w(context, 8),
        contentPadding: symmetric(context, horizontal: 12),
        leading: Container(
          height: h(context, 36),
          width: w(context, 36),
          decoration: BoxDecoration(
            color: kSecondaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CommonImageView(
              imagePath: Assets.imagesBell,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: CustomText(
          text: "Enable Notifications",
          size: 16,
          weight: FontWeight.w500,
          color: kBlackColor,
          fontFamily: AppFonts.HelveticaNowDisplay,
        ),
        trailing: CustomSwitch(),
      ),
    );
  }
}

void showDeleteConfirmationDialog({
  required VoidCallback onDeleteTap,
  required VoidCallback onCancelTap,
}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: kPrimaryColor,
      title: CustomText(
        text: 'Delete Account',
        weight: FontWeight.w700,
        size: 19,
        color: kSecondaryColor,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            paddingBottom: 10,
            text:
                'Are you sure you want to delete your account? This action cannot be undone.',
            color: kBlackColor,
          ),
          CustomTextfeildWidget(
            index: 1,
            controller:
                Get.find<ProfileController>().accountDeletionPasswordController,
            hintText: 'Enter password...',
          ),
        ],
      ),
      actions: <Widget>[
        CustomText(
          onTap: onDeleteTap,
          text: 'Delete Account',
          color: kSecondaryColor,
        ),
        const SizedBox(height: 10),
        CustomText(
          color: kBlackColor,
          onTap: () {
            Get.back();
            onCancelTap();
          },
          text: 'Cancel',
        ),
      ],
    ),
  );
}
