// import 'package:f2g/core/bindings/bindings.dart';
// import 'package:f2g/view/screens/createplan/filter_plan.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../constants/app_colors.dart';
// import '../../../constants/app_fonts.dart';
// import '../../../constants/app_styling.dart';
// import '../../widget/Custom_text_widget.dart';
// import '../../widget/custom_button_widget.dart';

// class FilterController extends GetxController {
//   Rx<RangeValues> peopleRange = const RangeValues(3, 45).obs;
//   Rx<RangeValues> ageRange = const RangeValues(18, 45).obs;
//   Rx<RangeValues> distanceRange = const RangeValues(5, 15).obs;
// }

// class FilterBottomSheet extends StatelessWidget {
//   FilterBottomSheet({super.key});

//   final FilterController controller = Get.put(FilterController());

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: w(context, 20),
//         right: w(context, 20),
//         bottom: h(context, 20),
//         top: h(context, 15),
//       ),
//       decoration: BoxDecoration(
//         color: kPrimaryColor,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(h(context, 20)),
//           topRight: Radius.circular(h(context, 20)),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               height: h(context, 5),
//               width: w(context, 40),
//               decoration: BoxDecoration(
//                 color: Color(0xffCDCDCD),
//                 borderRadius: BorderRadius.circular(h(context, 5)),
//               ),
//             ),
//           ),
//           SizedBox(height: h(context, 21)),
//           CustomText(
//             text: "Apply Filters",
//             size: 20,
//             weight: FontWeight.w700,
//             fontFamily: AppFonts.HelveticaNowDisplay,
//             color: Color(0xff0E0E0C),
//           ),
//           SizedBox(height: h(context, 18)),

//           // Container(
//           //   height: h(context, 46),
//           //   padding: symmetric(context, horizontal: 12),
//           //   decoration: BoxDecoration(
//           //     color: kWhiteColor,
//           //     borderRadius: BorderRadius.circular(h(context, 100)),
//           //   ),
//           //   child: Row(
//           //     children: [
//           //       Expanded(
//           //         child: CustomText(
//           //           text: "Select number of peoples",
//           //           size: 14,
//           //           weight: FontWeight.w500,
//           //           color: kBlackColor,
//           //           fontFamily: AppFonts.HelveticaNowDisplay,
//           //         ),
//           //       ),
//           //       Icon(Icons.keyboard_arrow_down, color: kBlackColor),
//           //     ],
//           //   ),
//           // ),
//           CustomText(
//             text: "Select People",
//             size: 14,
//             weight: FontWeight.w500,
//             color: kBlackColor,
//             paddingBottom: 8,
//             fontFamily: AppFonts.HelveticaNowDisplay,
//           ),
//           Container(
//             padding: only(context, bottom: 10),
//             width: w(context, double.maxFinite),
//             decoration: BoxDecoration(
//               color: kWhiteColor,
//               borderRadius: BorderRadius.circular(h(context, 8)),
//             ),
//             child: Obx(() {
//               final val = controller.peopleRange.value;
//               return Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       padding: all(context, 0),
//                       trackHeight: h(context, 8),
//                       rangeTrackShape: RoundedRectRangeSliderTrackShape(),
//                       activeTrackColor: kSecondaryColor,
//                       inactiveTrackColor: kPrimaryColor,
//                       thumbColor: kSecondaryColor,
//                       rangeThumbShape: WhiteBorderThumbShape(
//                         radius: h(context, 8),
//                         thumbColor: kSecondaryColor,
//                         borderColor: Colors.white,
//                         borderWidth: 1,
//                       ),
//                     ),
//                     child: RangeSlider(
//                       values: val,
//                       min: 3,
//                       max: 60,
//                       onChanged: (v) => controller.peopleRange.value = v,
//                     ),
//                   ),

//                   Positioned(
//                     left:
//                         (val.start / 60) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.start.toInt()} people to",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                   Positioned(
//                     right:
//                         ((60 - val.end) / 60) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.end.toInt()} people",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           SizedBox(height: h(context, 16)),
//           CustomText(
//             text: "Select Age",
//             size: 14,
//             weight: FontWeight.w500,
//             color: kBlackColor,
//             paddingBottom: 8,
//             fontFamily: AppFonts.HelveticaNowDisplay,
//           ),
//           Container(
//             padding: only(context, bottom: 10),
//             width: w(context, double.maxFinite),
//             decoration: BoxDecoration(
//               color: kWhiteColor,
//               borderRadius: BorderRadius.circular(h(context, 8)),
//             ),
//             child: Obx(() {
//               final val = controller.ageRange.value;
//               return Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       padding: all(context, 0),
//                       trackHeight: h(context, 8),
//                       rangeTrackShape: RoundedRectRangeSliderTrackShape(),
//                       activeTrackColor: kSecondaryColor,
//                       inactiveTrackColor: kPrimaryColor,
//                       thumbColor: kSecondaryColor,
//                       rangeThumbShape: WhiteBorderThumbShape(
//                         radius: h(context, 8),
//                         thumbColor: kSecondaryColor,
//                         borderColor: Colors.white,
//                         borderWidth: 1,
//                       ),
//                     ),
//                     child: RangeSlider(
//                       values: val,
//                       min: 18,
//                       max: 70,
//                       onChanged: (v) => controller.ageRange.value = v,
//                     ),
//                   ),

//                   Positioned(
//                     left:
//                         (val.start / 60) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.start.toInt()} yrs to",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                   Positioned(
//                     right:
//                         ((60 - val.end) / 60) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.end.toInt()} yrs",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           SizedBox(height: h(context, 16)),
//           CustomText(
//             text: "Select Distance",
//             size: 14,
//             paddingBottom: 8,
//             weight: FontWeight.w500,
//             color: kBlackColor,
//             fontFamily: AppFonts.HelveticaNowDisplay,
//           ),
//           Container(
//             padding: only(context, bottom: 10),
//             width: w(context, double.maxFinite),
//             decoration: BoxDecoration(
//               color: kWhiteColor,
//               borderRadius: BorderRadius.circular(h(context, 8)),
//             ),
//             child: Obx(() {
//               final val = controller.distanceRange.value;
//               return Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       padding: all(context, 0),
//                       trackHeight: h(context, 8),
//                       rangeTrackShape: RoundedRectRangeSliderTrackShape(),
//                       activeTrackColor: kSecondaryColor,
//                       inactiveTrackColor: kPrimaryColor,
//                       thumbColor: kSecondaryColor,

//                       rangeThumbShape: WhiteBorderThumbShape(
//                         radius: h(context, 8),
//                         thumbColor: kSecondaryColor,
//                         borderColor: Colors.white,
//                         borderWidth: 1,
//                       ),
//                     ),
//                     child: RangeSlider(
//                       values: val,
//                       min: 1,
//                       max: 20,
//                       onChanged: (v) => controller.distanceRange.value = v,
//                     ),
//                   ),

//                   Positioned(
//                     left:
//                         (val.start / 20) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.start.toInt()} km",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                   Positioned(
//                     right:
//                         ((20 - val.end) / 20) *
//                         (MediaQuery.of(context).size.width - w(context, 50)),
//                     bottom: h(context, -4),
//                     child: CustomText(
//                       text: "${val.end.toInt()} km",
//                       size: 10,
//                       weight: FontWeight.w500,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                       color: kBlackColor,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           SizedBox(height: h(context, 20)),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomButton(
//                   onPressed: () {
//                     controller.peopleRange.value = const RangeValues(3, 45);
//                     controller.ageRange.value = const RangeValues(18, 45);
//                     controller.distanceRange.value = const RangeValues(5, 15);
//                   },
//                   text: "Reset",
//                   size: 18,
//                   weight: FontWeight.w500,
//                   fontFamily: AppFonts.Satoshi,
//                   iscustomgradient: true,
//                   gradient: LinearGradient(colors: [kWhiteColor, kWhiteColor]),
//                   borderradius: 100,
//                   color: kBlackColor.withValues(alpha: 0.7),
//                   height: 50,
//                 ),
//               ),
//               SizedBox(width: w(context, 8)),
//               Expanded(
//                 child: CustomButton(
//                   onPressed: () {
//                     Get.to(() => FilterScreenPage(), binding: PlanBindings());
//                   },
//                   text: "Apply Filters",
//                   iscustomgradient: true,
//                   size: 18,
//                   weight: FontWeight.w500,
//                   fontFamily: AppFonts.HelveticaNowDisplay,
//                   gradient: LinearGradient(
//                     colors: [Color(0xff62D5C3), Color(0xffD7FAB7)],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderradius: 100,
//                   color: kBlackColor,
//                   height: 50,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: h(context, 10)),
//         ],
//       ),
//     );
//   }
// }

// class WhiteBorderThumbShape extends RangeSliderThumbShape {
//   final double radius;
//   final Color thumbColor;
//   final Color borderColor;
//   final double borderWidth;

//   const WhiteBorderThumbShape({
//     required this.radius,
//     required this.thumbColor,
//     required this.borderColor,
//     required this.borderWidth,
//   });

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.fromRadius(radius);
//   }

//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     required Animation<double> activationAnimation,
//     required Animation<double> enableAnimation,
//     bool isDiscrete = false,
//     bool isEnabled = false,
//     bool isOnTop = false,
//     bool isPressed = false,
//     SliderThemeData? sliderTheme,
//     TextDirection? textDirection,
//     Thumb? thumb,
//   }) {
//     final Canvas canvas = context.canvas;

//     final Paint fillPaint = Paint()..color = thumbColor;
//     canvas.drawCircle(center, radius, fillPaint);

//     final Paint borderPaint =
//         Paint()
//           ..color = borderColor
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = borderWidth;
//     canvas.drawCircle(center, radius, borderPaint);
//   }
// }
import 'dart:developer';
import 'package:f2g/core/enums/categories_status.dart';
import 'package:f2g/view/screens/createplan/create_new_plan.dart';
import 'package:f2g/view/widget/number_selector.dart' show NumberSelector;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/custom_button_widget.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/view/screens/createplan/filter_plan.dart';

class FilterController extends GetxController {
  // Rx<RangeValues> peopleRange = const RangeValues(3, 95).obs;
  Rx<RangeValues> peopleRange = const RangeValues(3, 4).obs;
  // Rx<RangeValues> ageRange = const RangeValues(18, 43).obs;
  Rx<RangeValues> ageRange = const RangeValues(18, 25).obs;
  // Rx<RangeValues> distanceRange = const RangeValues(1, 19).obs;
  Rx<RangeValues> distanceRange = const RangeValues(1, 5).obs;
  Rxn<CategoriesStatus> selectedCategory = Rxn<CategoriesStatus>();
}

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});

  final FilterController controller = Get.put(FilterController());
  // var planCtrl = Get.find<PlanController>();
  final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - w(context, 50);

    return Container(
      padding: EdgeInsets.only(
        left: w(context, 20),
        right: w(context, 20),
        bottom: h(context, 20),
        top: h(context, 15),
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(h(context, 20)),
          topRight: Radius.circular(h(context, 20)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: h(context, 5),
                width: w(context, 40),
                decoration: BoxDecoration(
                  color: const Color(0xffCDCDCD),
                  borderRadius: BorderRadius.circular(h(context, 5)),
                ),
              ),
            ),
            SizedBox(height: h(context, 21)),
            CustomText(
              text: "applyFilters",
              size: 20,
              weight: FontWeight.w700,
              fontFamily: AppFonts.HelveticaNowDisplay,
              color: const Color(0xff0E0E0C),
            ),
            SizedBox(height: h(context, 18)),

            /// ----- SELECT PEOPLE -----
            CustomText(
              text: "selectPeople",
              size: 14,
              weight: FontWeight.w500,
              color: kBlackColor,
              paddingBottom: 8,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),

            Obx(
              () => CommonCard(
                min: "${controller.peopleRange.value.start.toInt()}",
                max: "${controller.peopleRange.value.end.toInt()}",
                onTapMin: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Min People",
                      minNumber: 3,
                      maxNumber: 300,
                      initialNumber:
                          controller.peopleRange.value.start
                              .toInt(), // ✅ Use current value
                      onNumberSelected: (selectedNumber) {
                        // ✅ Update the start value of the range
                        controller.peopleRange.value = RangeValues(
                          selectedNumber.toDouble(),
                          controller.peopleRange.value.end,
                        );
                        print("Selected min people: $selectedNumber");
                      },
                      onCancel: () {
                        print("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                onTapMax: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Max People",
                      minNumber:
                          controller.peopleRange.value.start.toInt() +
                          1, // ✅ Max must be > Min
                      maxNumber: 300,
                      initialNumber:
                          controller.peopleRange.value.end
                              .toInt(), // ✅ Use current value
                      onNumberSelected: (selectedNumber) {
                        // ✅ Update the end value of the range
                        controller.peopleRange.value = RangeValues(
                          controller.peopleRange.value.start,
                          selectedNumber.toDouble(),
                        );
                        print("Selected max people: $selectedNumber");
                      },
                      onCancel: () {
                        print("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
              ),
            ),

            // Obx(() {
            //   final val = controller.peopleRange.value;
            //   return Padding(
            //     padding: EdgeInsets.only(bottom: h(context, 5)),
            //     child: CustomText(
            //       text:
            //           "${val.start.toInt()} people to ${val.end.toInt()} people",
            //       size: 12,
            //       weight: FontWeight.w500,
            //       color: kBlackColor.withValues(alpha: 0.8),
            //     ),
            //   );
            // }),
            // _buildRangeSlider(
            //   context,
            //   controller.peopleRange,
            //   min: 3,
            //   max: 200,
            //   minText: 'p',
            //   maxText: 'p',
            //   screenWidth: screenWidth,
            // ),
            SizedBox(height: h(context, 16)),

            /// ----- SELECT AGE -----
            CustomText(
              text: "selectAge",
              size: 14,
              weight: FontWeight.w500,
              color: kBlackColor,
              paddingBottom: 8,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),

            Obx(
              () => CommonCard(
                min: "${controller.ageRange.value.start.toInt()}",
                max: "${controller.ageRange.value.end.toInt()}",
                onTapMin: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Min Age",
                      minNumber: 18,
                      maxNumber:
                          controller.ageRange.value.end.toInt() -
                          1, // ✅ Min must be < Max
                      initialNumber: controller.ageRange.value.start.toInt(),
                      onNumberSelected: (selectedNumber) {
                        // ✅ Validate and update the start value
                        if (selectedNumber <
                            controller.ageRange.value.end.toInt()) {
                          controller.ageRange.value = RangeValues(
                            selectedNumber.toDouble(),
                            controller.ageRange.value.end,
                          );
                          log("Selected min age: $selectedNumber");
                        } else {
                          Get.snackbar(
                            'Invalid Range',
                            'Minimum age must be less than maximum age.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      onCancel: () {
                        log("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                onTapMax: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Max Age",
                      minNumber:
                          controller.ageRange.value.start.toInt() +
                          1, // ✅ Max must be > Min
                      maxNumber: 80,
                      initialNumber: controller.ageRange.value.end.toInt(),
                      onNumberSelected: (selectedNumber) {
                        // ✅ Validate and update the end value (FIXED)
                        if (selectedNumber >
                            controller.ageRange.value.start.toInt()) {
                          controller.ageRange.value = RangeValues(
                            controller.ageRange.value.start,
                            selectedNumber
                                .toDouble(), // ✅ FIXED: Only 2 parameters
                          );
                          log("Selected max age: $selectedNumber");
                        } else {
                          Get.snackbar(
                            'Invalid Range',
                            'Maximum age must be greater than minimum age.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      onCancel: () {
                        log("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
              ),
            ),

            // Obx(() {
            //   final val = controller.ageRange.value;
            //   return Padding(
            //     padding: EdgeInsets.only(bottom: h(context, 5)),
            //     child: CustomText(
            //       // text: "${val.start.toInt()} yrs to ${val.end.toInt()} yrs",
            //       text:
            //           (val.end == 65)
            //               ? "${val.start.toInt()} yrs to +${val.end.toInt()} yrs"
            //               : "${val.start.toInt()} yrs to ${val.end.toInt()} yrs",
            //       size: 12,
            //       weight: FontWeight.w500,
            //       color: kBlackColor.withValues(alpha: 0.8),
            //     ),
            //   );
            // }),
            // _buildRangeSlider(
            //   context,
            //   controller.ageRange,
            //   min: 18,
            //   max: 65,
            //   minText: 'p',
            //   maxText: 'p',
            //   screenWidth: Get.width / 3,
            // ),
            SizedBox(height: h(context, 16)),

            /// ----- SELECT DISTANCE -----
            CustomText(
              text: "selectDistance",
              size: 14,
              paddingBottom: 8,
              weight: FontWeight.w500,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),

            Obx(
              () => CommonCard(
                min: "${controller.distanceRange.value.start.toInt()}",
                max: "${controller.distanceRange.value.end.toInt()}",
                onTapMin: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Min Distance",
                      minNumber: 1,
                      maxNumber:
                          controller.distanceRange.value.end.toInt() -
                          1, // ✅ Min must be < Max
                      initialNumber:
                          controller.distanceRange.value.start.toInt(),
                      onNumberSelected: (selectedNumber) {
                        // ✅ Validate and update the start value
                        if (selectedNumber <
                            controller.distanceRange.value.end.toInt()) {
                          controller.distanceRange.value = RangeValues(
                            selectedNumber.toDouble(),
                            controller.distanceRange.value.end,
                          );
                          log("Selected min distance: $selectedNumber");
                        } else {
                          Get.snackbar(
                            'Invalid Range',
                            'Minimum distance must be less than maximum distance.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      onCancel: () {
                        log("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                onTapMax: () {
                  Get.bottomSheet(
                    NumberSelector(
                      title: "Max Distance",
                      minNumber:
                          controller.distanceRange.value.start.toInt() +
                          1, // ✅ Max must be > Min
                      maxNumber: 80,
                      initialNumber: controller.distanceRange.value.end.toInt(),
                      onNumberSelected: (selectedNumber) {
                        // ✅ Validate and update the end value (FIXED)
                        if (selectedNumber >
                            controller.distanceRange.value.start.toInt()) {
                          controller.distanceRange.value = RangeValues(
                            controller.distanceRange.value.start,
                            selectedNumber
                                .toDouble(), // ✅ FIXED: Only 2 parameters
                          );
                          log("Selected max distance: $selectedNumber");
                        } else {
                          Get.snackbar(
                            'Invalid Range',
                            'Maximum distance must be greater than minimum distance.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      onCancel: () {
                        log("Cancelled");
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
              ),
            ),

            // Obx(() {
            //   final val = controller.distanceRange.value;
            //   return Padding(
            //     padding: EdgeInsets.only(bottom: h(context, 5)),
            //     child: CustomText(
            //       text: "${val.start.toInt()} km to ${val.end.toInt()} km",
            //       size: 12,
            //       weight: FontWeight.w500,
            //       color: kBlackColor.withValues(alpha: 0.8),
            //     ),
            //   );
            // }),
            // _buildRangeSlider(
            //   context,
            //   controller.distanceRange,
            //   min: 1,
            //   max: 40,
            //   minText: 'Km',
            //   maxText: 'Km',
            //   screenWidth: screenWidth,
            // ),
            SizedBox(height: h(context, 20)),

            // Drop Down will be here --------------------------
            // -------------------------------------------------
            // -------------------------------------------------
            Obx(
              () => CustomDropdownField(
                label: "${"category".tr}",
                selectedValue: controller.selectedCategory.value,
                onChanged: (value) {
                  controller.selectedCategory.value = value;
                  log("Log :: ${controller.selectedCategory.value?.name}");
                },
              ),
            ),
            SizedBox(height: h(context, 20)),

            // -------------------------------------------------
            // -------------------------------------------------

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // controller.peopleRange.value = const RangeValues(3, 95);
                      // controller.ageRange.value = const RangeValues(18, 43);
                      // controller.distanceRange.value = const RangeValues(1, 19);
                      controller.peopleRange.value = const RangeValues(3, 4);
                      controller.ageRange.value = const RangeValues(18, 25);
                      controller.distanceRange.value = const RangeValues(1, 5);
                      controller.selectedCategory.value = null;
                    },
                    text: "reset".tr,
                    size: 18,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.Satoshi,
                    iscustomgradient: true,
                    gradient: LinearGradient(
                      colors: [kWhiteColor, kWhiteColor],
                    ),
                    borderradius: 100,
                    color: kBlackColor.withValues(alpha: 0.7),
                    height: 50,
                  ),
                ),
                SizedBox(width: w(context, 8)),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.close(1);
                      Get.to(
                        () => FilterScreenPage(
                          categoryFilter:
                              controller.selectedCategory.value?.name,
                        ),
                        binding: PlanBindings(),
                      );
                    },
                    text: "applyFilters",
                    iscustomgradient: true,
                    size: 18,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    gradient: const LinearGradient(
                      colors: [Color(0xff62D5C3), Color(0xffD7FAB7)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderradius: 100,
                    color: kBlackColor,
                    height: 50,
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 10)),
          ],
        ),
      ),
    );
  }

  /// SLIDER BUILDER WITH OVERLAP FIX
  Widget _buildRangeSlider(
    BuildContext context,
    Rx<RangeValues> range, {
    required double min,
    required double max,
    required double screenWidth,
    required String minText,
    required String maxText,
  }) {
    return Container(
      padding: only(context, bottom: 10),
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 8)),
      ),
      child: Obx(() {
        final val = range.value;
        final double diff = (val.end - val.start);

        // dynamically adjust label position when values are close
        final double startLeft = (val.start / max) * screenWidth;
        final double endRight = ((max - val.end) / max) * screenWidth;

        final bool overlap = diff < 5;
        // final bool overlap = diff < 5;
        final double labelSpacing = overlap ? 25 : 0;
        // final double labelSpacing = overlap ? 25 : 0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: h(context, 8),
                activeTrackColor: kSecondaryColor,
                inactiveTrackColor: kPrimaryColor,
                thumbColor: kSecondaryColor,
                rangeThumbShape: WhiteBorderThumbShape(
                  radius: h(context, 8),
                  thumbColor: kSecondaryColor,
                  borderColor: Colors.white,
                  borderWidth: 1,
                ),
              ),
              child: RangeSlider(
                values: val,
                min: min,
                max: max,
                onChanged: (v) => range.value = v,
              ),
            ),

            // /// Start label
            // Positioned(
            //   left: 20,
            //   bottom: h(context, -4),
            //   child: Transform.translate(
            //     offset: Offset(-labelSpacing, 0),
            //     child: CustomText(
            //       text: "${val.start.toInt()}",
            //       size: 10,
            //       weight: FontWeight.w500,
            //       fontFamily: AppFonts.HelveticaNowDisplay,
            //       color: kBlackColor,
            //     ),
            //   ),
            // ),

            // /// End label
            // Positioned(
            //   right: endRight,
            //   bottom: h(context, -4),
            //   child: Transform.translate(
            //     offset: Offset(labelSpacing, 0),
            //     child: CustomText(
            //       text: "${val.end.toInt()}",
            //       size: 10,
            //       weight: FontWeight.w500,
            //       fontFamily: AppFonts.HelveticaNowDisplay,
            //       color: kBlackColor,
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}

class CommonCard extends StatelessWidget {
  final String? min, max;
  final VoidCallback? onTapMin, onTapMax;
  const CommonCard({
    super.key,
    this.min,
    this.max,
    this.onTapMin,
    this.onTapMax,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTapMin,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(h(context, 8)),
              ),
              child: Center(
                child: CustomText(
                  text: min ?? "Min",
                  size: 14,
                  weight: min == null ? FontWeight.w400 : FontWeight.w500,
                  color:
                      min == null
                          ? kBlackColor.withValues(alpha: .5)
                          : kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
            ),
          ),
        ),

        CustomText(
          paddingLeft: 20,
          paddingRight: 20,
          text: "To",
          size: 14,
          weight: FontWeight.w400,
          color: kBlackColor,
          fontFamily: AppFonts.HelveticaNowDisplay,
        ),

        Expanded(
          child: InkWell(
            onTap: onTapMax,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(h(context, 8)),
              ),
              child: Center(
                child: CustomText(
                  text: max ?? "Max",
                  size: 14,
                  weight: max == null ? FontWeight.w400 : FontWeight.w500,
                  color:
                      max == null
                          ? kBlackColor.withValues(alpha: .5)
                          : kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WhiteBorderThumbShape extends RangeSliderThumbShape {
  final double radius;
  final Color thumbColor;
  final Color borderColor;
  final double borderWidth;

  const WhiteBorderThumbShape({
    required this.radius,
    required this.thumbColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    bool isPressed = false,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;
    final Paint fillPaint = Paint()..color = thumbColor;
    canvas.drawCircle(center, radius, fillPaint);

    final Paint borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;
    canvas.drawCircle(center, radius, borderPaint);
  }
}
