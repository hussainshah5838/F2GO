import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ViewPicture extends StatelessWidget {
  String imageUrl;
  ViewPicture({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          paddingLeft: 12,
          text: 'View Image',
          size: 16.43,
          paddingBottom: 2,
          weight: FontWeight.w600,
          color: kSecondaryColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        child: Column(
          children: [
            Expanded(
              child: CommonImageView(url: imageUrl, fit: BoxFit.contain),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Close',
              onPressed: () {
                Get.close(1);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class AppSizes {}
