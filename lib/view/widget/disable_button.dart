import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:flutter/widgets.dart';

class DisableButton extends StatelessWidget {
  String text;
  DisableButton({super.key, this.text = "Completed"});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      iscustomgradient: true,
      gradient: LinearGradient(
        colors: [
          Color(0xff62D5C3).withValues(alpha: 0.5),
          Color(0xffD7FAB7).withValues(alpha: 0.5),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderradius: 100,
      size: 18,
      weight: FontWeight.w500,
      fontFamily: AppFonts.HelveticaNowDisplay,
      color:
      // ? kBlackColor
      kBlackColor.withValues(alpha: 0.5),
      height: 50,
      width: double.maxFinite,
    );
  }
}
