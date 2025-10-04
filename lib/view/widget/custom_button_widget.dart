import 'package:f2g/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_styling.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final double? borderwidth;
  final double? size;
  final Color? color;
  final Color? backgroundcolor;
  final Color? bordercolor;
  final Color? textcolor;
  final String? imagePath;
  final TextStyle? style;
  final FontWeight? weight;
  final String? fontFamily;
  final bool isimage;
  final bool isboxshadow;
  final bool isborder;
  final bool iscustomgradient;
  final bool isgradientborder;
  final double? borderradius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.text,
    this.size = 14,
    this.color,
    this.imagePath,
    this.height = 47,
    this.width = double.maxFinite,
    this.textcolor,
    this.style,
    this.isimage = false,
    this.weight,
    this.isgradientborder = false,
    this.backgroundcolor,
    this.onPressed,
    this.isboxshadow = false,
    this.isborder = false,
    this.iscustomgradient = false,
    this.bordercolor,
    this.borderwidth,
    this.fontFamily,
    this.borderradius,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, width),
      height: h(context, height),
      decoration: BoxDecoration(
        gradient: iscustomgradient
            ? gradient
            : LinearGradient(
                colors: kButtonGradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),

        color: backgroundcolor ?? null,

        border: isborder
            ? Border.all(
                color: bordercolor ?? Colors.transparent,
                width: borderwidth ?? 1.0,
              )
            : null,
        borderRadius: BorderRadius.circular(h(context, borderradius ?? 42)),
        boxShadow:
            boxShadow ??
            [
              isboxshadow
                  ? BoxShadow(
                      color: Color(0xff532FAA).withValues(alpha: 0.2),
                      offset: Offset(0, 6),
                      blurRadius: 10,
                      spreadRadius: 0,
                    )
                  : BoxShadow(color: Colors.transparent),
            ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: color,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(h(context, borderradius ?? 42)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isimage)
              CommonImageView(
                imagePath: imagePath,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
            if (isimage) SizedBox(width: w(context, 4)),
            CustomText(
              textAlign: TextAlign.center,
              text: text,
              weight: weight,
              fontFamily: fontFamily ?? AppFonts.Poppins,
              size: size,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
