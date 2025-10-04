import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/auth/login/login.dart';

class Onboardingcontroller extends GetxController {
  final pageController = PageController();
  final currentSlide = 0.obs;

  final List<String> title = [
    'Meet New People,\nShare Real Moments',
    'Find Plans That\nMatch Your Interests',
    'Connect, Chat\n& Make It Happen',
  ];

  final List<String> detail = [
    'Discover like-minded individuals nearby who are up for\ncoffee, a walk in the park, or spontaneous adventures.',
    'Whether it’s bowling, beach time, or book clubs\nexplore activities others are hosting.',
    'Chat instantly with potential matches, coordinate the\nplan, and meet up in real life safely & easily',
  ];

  void onPageChanged(int index) {
    currentSlide.value = index;
  }

  void nextSlide() {
    if (currentSlide.value < title.length - 1) {
      pageController.animateToPage(
        currentSlide.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentSlide.value++;
    } else {
      Get.offAll(LoginScreen());
    }
  }

  void previousSlide() {
    if (currentSlide.value > 0) {
      pageController.animateToPage(
        currentSlide.value - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentSlide.value--;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
