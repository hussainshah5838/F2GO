import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MyLoadingScreen extends StatefulWidget {
  const MyLoadingScreen({super.key});

  @override
  State<MyLoadingScreen> createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for 3 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Create smooth linear animation from 0 to 1
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Start the animation
    _controller.forward();

    // Navigate to Home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => HomeScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesSplashScreenbackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hexagonDotsLoading(),
                const SizedBox(height: 24),
                // Text
                CustomText(
                  text: "Finding your next plan...",
                  color: kBlackColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 24),

                // Linear Progress Indicator
                SizedBox(
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _animation.value,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        kSecondaryColor,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
