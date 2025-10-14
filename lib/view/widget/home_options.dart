import 'package:f2g/constants/app_fonts.dart' show AppFonts;
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

class HomeOptionsContainer extends StatelessWidget {
  final String? image;
  final String? text;
  final String? subtext;
  final String? value;
  final Color? color;
  final VoidCallback? onTap;
  const HomeOptionsContainer({
    super.key,
    this.image,
    this.text,
    this.subtext,
    this.value,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: symmetric(context, vertical: 14.5),
        width: w(context, double.maxFinite),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, 15)),
          color: color,
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Color(0xff28E4D3).withValues(alpha: 0.6),
                Color(0xffA2F690).withValues(alpha: 0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        child: Column(
          children: [
            CommonImageView(
              imagePath: image,
              height: 72,
              width: 72,
              fit: BoxFit.contain,
            ),
            SizedBox(height: h(context, 16)),
            CustomText(
              text: text!,
              size: 15,
              weight: FontWeight.w500,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 2,
            ),
            // CustomText(
            //   text: subtext!,
            //   size: 15,
            //   weight: FontWeight.w500,
            //   color: kBlackColor.withValues(alpha: 0.8),
            //   fontFamily: AppFonts.HelveticaNowDisplay,
            // ),
          ],
        ),
      ),
    );
  }
}
