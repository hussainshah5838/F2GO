import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/screens/auth/login/login.dart';

class Onboardingcontroller extends GetxController {
  final pageController = PageController();
  final currentSlide = 0.obs;

  final List<String> title = [
    'Meet New People,\nShare Real Moments',
    'Find Plans That\nMatch Your Interests',
    'Connect, Chat\n& Make It Happen',
    // "Conoce gente nueva, comparte momentos reales",
    // "Encuentra planes que se adapten a tus intereses",
    // "Conecta, chatea y haz que suceda.",
  ];

  final List<String> detail = [
    // "Descubre personas cercanas que quieran tomar un café, dar un paseo por el parque o vivir aventuras espontáneas.",
    // "Ya sea ir a los bolos, ir a la playa o unirte a clubs de lectura, explora las actividades que otros están organizando.",
    // "Coordina el plan, chatea al instante y queda en la vida real de forma fácil y segura.",
    'Discover like-minded individuals nearby who are up for\ncoffee, a walk in the park, or spontaneous adventures.',
    'Whether it’s bowling, beach time, or book clubs\nexplore activities others are hosting.',
    'Chat instantly with potential matches, coordinate the\nplan, and meet up in real life safely & easily',
  ];

  void onPageChanged(int index) {
    currentSlide.value = index;
  }

  void nextSlide() async {
    if (currentSlide.value < title.length - 1) {
      pageController.animateToPage(
        currentSlide.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentSlide.value++;
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('key', true);
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
