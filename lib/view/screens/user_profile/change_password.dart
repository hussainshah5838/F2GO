import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/editprofile_controller.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/Common_image_view_widget.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_textfeild_widget.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  ProfileController ctrl = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                      SizedBox(width: w(context, 16)),
                      Expanded(
                        child: CustomText(
                          text: "Change Password",
                          size: 16,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(context, 20)),
                  buildPasswordField(
                    context,
                    label: "Current Password",
                    controller: ctrl.currentPasswordController,
                    //     controllers.changeCurrentpasswordController.value,
                  ),
                  SizedBox(height: h(context, 12)),
                  Divider(
                    color: Color(0xffE3E3E3),
                    thickness: h(context, 1),
                    height: h(context, 1),
                  ),
                  SizedBox(height: h(context, 12)),
                  buildPasswordField(
                    context,
                    label: "New Password",
                    controller: ctrl.newPasswordController,
                    // controller: controllers.changeNewPasswordController.value,
                  ),
                  SizedBox(height: h(context, 8)),

                  buildPasswordField(
                    context,
                    label: "Confirm new password",
                    controller: ctrl.confirmPasswordController,
                    // controller:
                    //     controllers.changeConfirmNewPasswordController.value,
                  ),
                  Spacer(),
                  CustomButton(
                    // onPressed: _updatePassword,
                    text: "Update",
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
                    onPressed: () {
                      if (ctrl.currentPasswordController.text.isEmpty) {
                        displayToast(msg: "Please fill the current password");
                        return;
                      }
                      if (ctrl.newPasswordController.text.isEmpty) {
                        displayToast(msg: "Please fill the new password");
                        return;
                      }
                      if (ctrl.confirmPasswordController.text.isEmpty) {
                        displayToast(msg: "Please fill the confirm password");
                        return;
                      }

                      if (ctrl.newPasswordController.text !=
                          ctrl.confirmPasswordController.text) {
                        displayToast(msg: "Both password not matched");
                        return;
                      }
                    },
                  ),
                  SizedBox(height: h(context, 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
