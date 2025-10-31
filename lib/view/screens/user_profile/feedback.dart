import 'package:f2g/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/Common_image_view_widget.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_textfeild_widget.dart';

class AppFeedbackScreen extends StatelessWidget {
  AppFeedbackScreen({super.key});

  // final TextControllers controllers = Get.find<TextControllers>();

  void _submitFeedback() {
    Get.snackbar(
      "Success",
      "Feedback submitted successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kSecondaryColor,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
    nameCtrl.clear();
    descriptionCtrl.clear();
    Get.close(1);
  }

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // controllers.feedbackNameController.value.text = "Christopher Henry";
    // controllers.feedbackController.value.text =
    //     "Lorem ipsum dolor ist amet contestu anti";

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
                          text: "App Feedback",
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
                    label: "Full name",
                    controller: nameCtrl,
                    // controller: controllers.feedbackNameController.value,
                  ),

                  SizedBox(height: h(context, 8)),

                  Container(
                    height: h(context, 152),
                    width: double.maxFinite,
                    padding: all(context, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(h(context, 12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Your feedback",
                          size: 14,
                          lineHeight: h(context, 0.5),
                          color: kBlackColor.withValues(alpha: 0.5),
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        SizedBox(height: h(context, 6)),
                        TextFormField(
                          controller: descriptionCtrl,
                          // controller: controllers.feedbackController.value,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: f(context, 16),
                            fontWeight: FontWeight.w500,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: _submitFeedback,
                    text: "Submit",
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
