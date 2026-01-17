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
  int? minimumDate, maximumDate;
  DateTimePicker({
    super.key,
    required this.onDateTimeChanged,
    this.initialDateTime,
    this.mode = CupertinoDatePickerMode.time,
    this.height,
    this.onTap,
    this.title,
    this.maximumDate,
    this.minimumDate,
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
              minimumYear: minimumDate ?? 1995,
              maximumYear: maximumDate ?? 2080,
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

// ignore: must_be_immutable
class NumberSelector extends StatefulWidget {
  final Function(String) onNumberSelected;
  final String? initialNumber;
  final String? title;
  final VoidCallback? onTap;

  const NumberSelector({
    super.key,
    required this.onNumberSelected,
    this.initialNumber,
    this.title,
    this.onTap,
  });

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  int _selectedNumber = 3;

  @override
  void initState() {
    super.initState();
    if (widget.initialNumber != null) {
      _selectedNumber = int.tryParse(widget.initialNumber!) ?? 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 7,
            width: 80,
            decoration: BoxDecoration(
              color: kBlackColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          if (widget.title != null)
            CustomText(
              text: widget.title ?? "",
              color: kBlackColor,
              size: 20,
              weight: FontWeight.w600,
            ),

          SizedBox(
            height: Get.height * 0.30,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: _selectedNumber - 3,
              ),
              itemExtent: 40,
              magnification: 1.2,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedNumber = index + 3;
                });
                widget.onNumberSelected(_selectedNumber.toString());
              },
              children: List<Widget>.generate(
                998, // From 3 to 1000
                (index) => Center(
                  child: Text(
                    '${index + 3}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: CustomButton(
              onPressed: widget.onTap,
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
