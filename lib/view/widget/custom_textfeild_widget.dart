import 'package:f2g/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_fonts.dart';
import '../../constants/app_styling.dart';
import '../../controller/focus_controller.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

class CustomTextfeildWidget extends StatelessWidget {
  final int index;
  final TextEditingController? controller;
  final bool issuffix;
  final bool obscureText;
  final String? hintText;
  final void Function()? onTap;
  final String? suffixicon;
  final void Function(String)? onChanged;
  final bool errorBorder;
  CustomTextfeildWidget({
    super.key,
    this.controller,
    this.issuffix = false,
    this.obscureText = false,
    this.onTap,
    this.suffixicon,
    this.hintText,
    required this.index,
    this.onChanged,
    this.errorBorder = false,
  });

  final focusController = Get.put(FocusController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: symmetric(context, horizontal: 20),
      padding: symmetric(context, horizontal: 14),
      height: h(context, 52),
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(
          color:
              errorBorder
                  ? Color(0xffEA4335)
                  : kWhiteColor.withValues(alpha: 0.05),
        ),
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(
              () => TextFormField(
                onChanged: onChanged,
                focusNode: focusController.focusNodes[index],
                obscureText: obscureText,
                controller: controller,

                style: TextStyle(
                  fontFamily: AppFonts.HelveticaNowDisplay,
                  fontSize: f(context, 15),
                  fontWeight: FontWeight.w500,
                  color: errorBorder ? Color(0xffEA4335) : kBlackColor,
                ),
                decoration: InputDecoration(
                  labelText: hintText ?? "Email address",
                  labelStyle: TextStyle(
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    fontSize: f(
                      context,
                      (focusController.isFocusedList[index].value ||
                              controller?.text.isNotEmpty == true)
                          ? 14
                          : 16,
                    ),
                    fontWeight: FontWeight.w500,
                    color:
                        (focusController.isFocusedList[index].value ||
                                controller?.text.isNotEmpty == true)
                            ? Color(0xff757575)
                            : Color(0xff191919),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: w(context, 10)),
          if (issuffix)
            InkWell(
              onTap: onTap,
              child: CommonImageView(
                imagePath: suffixicon,
                height: h(context, 24),
                width: w(context, 24),
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }
}

class CustomLabelTextFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool isheight;
  final double? height;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  TextInputType? keyboardType;
  CustomLabelTextFeild({
    super.key,
    this.controller,
    required this.label,
    this.height,
    this.isheight = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isheight ? h(context, height ?? 139) : null,
      padding: all(context, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: f(context, 16),
          fontWeight: FontWeight.w500,
          color: kBlackColor,
          fontFamily: AppFonts.HelveticaNowDisplay,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: f(context, 15),
            fontWeight: FontWeight.w500,
            color: kBlackColor.withValues(alpha: 0.5),
            fontFamily: AppFonts.HelveticaNowDisplay,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

Widget buildPasswordField(
  BuildContext context, {
  required String label,
  required TextEditingController controller,
}) {
  return Container(
    padding: all(context, 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(h(context, 12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          size: 14,
          lineHeight: h(context, 0.5),
          color: kBlackColor.withValues(alpha: 0.5),
          fontFamily: AppFonts.HelveticaNowDisplay,
        ),
        SizedBox(height: h(context, 6)),
        TextFormField(
          controller: controller,

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
  );
}
