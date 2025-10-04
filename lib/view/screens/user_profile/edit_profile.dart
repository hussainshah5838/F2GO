import 'package:f2g/constants/app_images.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../../controller/my_ctrl/editprofile_controller.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/Common_image_view_widget.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_textfeild_widget.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var controller = Get.find<ProfileController>();

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
                      SizedBox(width: w(context, 15)),
                      Expanded(
                        child: CustomText(
                          text: "Edit Profile",
                          size: 16,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 20)),

                  Container(
                    width: w(context, double.maxFinite),

                    padding: all(context, 10),
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [Color(0xff73DAC1), Color(0xffD2F8B7)],
                        ),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(h(context, 12)),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () =>
                              controller.selectedImage.value != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      h(context, 22),
                                    ),
                                    child: Image.file(
                                      controller.selectedImage.value!,
                                      height: h(context, 44),
                                      width: h(context, 44),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : CommonImageView(
                                    url:
                                        userService
                                            .userModel
                                            .value
                                            .profileImage,
                                    height: 44,
                                    width: 44,
                                    radius: 100,
                                    fit: BoxFit.fill,
                                  ),
                        ),
                        SizedBox(width: w(context, 8)),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Upload Profile Photo",
                                size: 16,
                                lineHeight: h(context, 1),
                                paddingBottom: 6,
                                weight: FontWeight.w500,
                                color: kBlackColor,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                              ),
                              CustomText(
                                text: "File size (100mb max)",
                                size: 12,
                                lineHeight: h(context, 1),
                                color: kBlackColor.withValues(alpha: 0.6),
                                fontFamily: AppFonts.HelveticaNowDisplay,
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            height: h(context, 29),
                            margin: EdgeInsets.all(
                              w(context, 1) > 1 ? 1 : w(context, 1),
                            ),
                            padding: only(context, left: 8, right: 12.5),
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff28E4D3),
                                    Color(0xffAFF888),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0, 1],
                                ),
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                h(context, 8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: "Upload",
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: kSecondaryColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                                SizedBox(width: w(context, 6)),
                                CommonImageView(
                                  imagePath: Assets.imagesVectordown,
                                  height: 10,
                                  width: 6,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h(context, 16)),
                  Divider(
                    color: Color(0xffE3E3E3),
                    height: h(context, 1),
                    thickness: h(context, 1),
                  ),
                  SizedBox(height: h(context, 16)),
                  CustomText(
                    text: "PERSONAL INFORMATION",
                    size: 12,
                    weight: FontWeight.w500,
                    color: ktextcolor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                  SizedBox(height: h(context, 14)),
                  buildPasswordField(
                    context,
                    label: "Full name",
                    controller: controller.nameController,
                  ),

                  // SizedBox(height: h(context, 8)),
                  // buildPasswordField(
                  //   context,
                  //   label: "Email address",
                  //   controller: controller.emailController,
                  // ),
                  SizedBox(height: h(context, 8)),

                  Container(
                    height: h(context, 153),
                    padding: all(context, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(h(context, 12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Biography",
                          size: 14,
                          lineHeight: h(context, 0.5),
                          color: kBlackColor.withValues(alpha: 0.5),
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        SizedBox(height: h(context, 8)),
                        TextFormField(
                          controller: controller.biographyController,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: f(context, 16),
                            fontWeight: FontWeight.w500,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  CustomButton(
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
                    // onPressed: controller.updateProfile,
                    onPressed: () {
                      if (controller.nameController.text.isEmpty) {
                        displayToast(msg: "Name can't be empty");
                        return;
                      }
                      if (controller.biographyController.text.isEmpty) {
                        displayToast(msg: "Biography can't be empty");
                        return;
                      }

                      controller.updateUserInfo(
                        name: controller.nameController.text.trim(),
                        bio: controller.biographyController.text.trim(),
                        profileImage: controller.profileImageUrl,
                      );
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
