import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';

class ImageSlider extends StatelessWidget {
  final PageController pageController;
  final Function(int) onChange;
  final int currentSlide;

  const ImageSlider({
    super.key,
    required this.pageController,
    required this.onChange,
    required this.currentSlide,
    required BoxFit fit,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: onChange,
      physics: ClampingScrollPhysics(),
      children: [
        Image.asset(Assets.imagesOnboardingimage1, fit: BoxFit.cover),
        Image.asset(Assets.imagesOnboardingimage2, fit: BoxFit.cover),
        Image.asset(Assets.imagesOnboardingimage3, fit: BoxFit.cover),
      ],
    );
  }
}
