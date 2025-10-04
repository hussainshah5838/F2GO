import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DateTimePicker extends StatelessWidget {
  final Function(dynamic) onDateTimeChanged;
  final DateTime? initialDateTime;
  var mode;
  VoidCallback? onTap;
  double? height;
  String? title;
  DateTimePicker({
    super.key,
    required this.onDateTimeChanged,
    this.initialDateTime,
    this.mode = CupertinoDatePickerMode.time,
    this.height,
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            height: 7,
            width: 80,
            decoration: BoxDecoration(
              color: kBlackColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          (title != null)
              ? CustomText(
                text: title ?? "",
                color: kBlackColor,
                size: 20,
                weight: FontWeight.w600,
              )
              : SizedBox.shrink(),
          SizedBox(
            height: height ?? Get.height * 0.30,
            child: CupertinoDatePicker(
              minimumYear: 1995,
              maximumYear: 2080,
              mode: mode,
              dateOrder: DatePickerDateOrder.dmy,
              //  showDayOfWeek: false,
              initialDateTime: initialDateTime,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),

          // Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: CustomButton(
              onPressed: onTap,

              text: "Done",
              iscustomgradient: true,
              gradient: const LinearGradient(
                colors: [Color(0xff21E3D7), Color(0xffB5F985)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderradius: 100,
              size: 18,
              weight: FontWeight.w500,
              fontFamily: AppFonts.HelveticaNowDisplay,
              color: kBlackColor,
              height: 50,
              width: double.maxFinite,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
