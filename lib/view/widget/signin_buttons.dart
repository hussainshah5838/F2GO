import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';
import 'common_image_view_widget.dart';

class SigninButtons extends StatelessWidget {
  final String image;
  final void Function() onTap;

  const SigninButtons({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: h(context, 51),
        width: w(context, 112),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(h(context, 121)),
        ),
        child: Center(
          child: CommonImageView(
            imagePath: image,
            height: 24.4,
            width: 24.4,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
