import 'dart:developer';

import 'package:f2g/constants/app_images.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/categories_status.dart';
import 'package:f2g/view/widget/custom_textfeild_widget.dart';
import 'package:f2g/view/widget/dob_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/Common_image_view_widget.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_styling.dart';
import '../../widget/custom_button_widget.dart';

// ignore: must_be_immutable
class CreateNewPlanScreen extends StatelessWidget {
  CreateNewPlanScreen({super.key});

  // final CreateNewPlanController controller = Get.put(CreateNewPlanController());
  // final TextControllers textControllers = Get.find<TextControllers>();
  final _ctrl = Get.find<PlanController>();
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesProfilebg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h(context, 20)),

                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: CommonImageView(
                          imagePath: Assets.imagesBackicon,
                          height: 48,
                          width: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: w(context, 15)),
                      Expanded(
                        child: CustomText(
                          text: "Create new plan",
                          size: 16,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 22)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: w(context, double.maxFinite),
                            padding: all(context, 10),
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff73DAC1),
                                    Color(0xffD2F8B7),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                h(context, 12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Obx(
                                  () =>
                                      _ctrl.selectedImage.value != null
                                          ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              h(context, 22),
                                            ),
                                            child: Image.file(
                                              _ctrl.selectedImage.value!,
                                              height: h(context, 44),
                                              width: h(context, 44),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          : CommonImageView(
                                            imagePath: Assets.imagesUpload,
                                            height: 44,
                                            width: 44,
                                            fit: BoxFit.contain,
                                          ),
                                ),
                                SizedBox(width: w(context, 8)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Upload Plan Photo",
                                        size: 16,
                                        lineHeight: h(context, 1),
                                        paddingBottom: 6,
                                        weight: FontWeight.w500,
                                        color: kBlackColor,
                                        fontFamily:
                                            AppFonts.HelveticaNowDisplay,
                                      ),
                                      CustomText(
                                        text: "File size (100mb max)",
                                        size: 12,
                                        weight: FontWeight.w500,
                                        lineHeight: h(context, 1),
                                        color: kBlackColor.withValues(
                                          alpha: 0.6,
                                        ),
                                        fontFamily:
                                            AppFonts.HelveticaNowDisplay,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _ctrl.pickImage,
                                  child: Container(
                                    height: h(context, 29),
                                    margin: EdgeInsets.all(
                                      w(context, 1) > 1 ? 1 : w(context, 1),
                                    ),
                                    padding: only(
                                      context,
                                      left: 8,
                                      right: 12.5,
                                    ),
                                    decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff28E4D3),
                                            Color(0xffAFF888),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          stops: [0, 1],
                                        ),
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        h(context, 8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: "Upload",
                                          size: 12,
                                          weight: FontWeight.w500,
                                          color: kSecondaryColor,
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                        ),
                                        SizedBox(width: w(context, 6)),
                                        CommonImageView(
                                          imagePath: Assets.imagesVectordown,
                                          height: 10,
                                          width: 6,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h(context, 8)),
                          Divider(
                            color: Color(0xffE3E3E3),
                            height: h(context, 1),
                            thickness: h(context, 1),
                          ),
                          SizedBox(height: h(context, 8)),
                          CustomLabelTextFeild(
                            label: "Plan Title",
                            controller: _ctrl.titleController,
                          ),
                          SizedBox(height: h(context, 8)),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: CustomLabelTextFeild(
                                    label: "Start Date",
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text:
                                          (_ctrl.startDate.value != null)
                                              ? dT.getDateIsoFormat(
                                                _ctrl.startDate.value!,
                                              )
                                              : '-',
                                    ),
                                    onTap: () {
                                      Get.bottomSheet(
                                        DateTimePicker(
                                          title: "Start Date",
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (v) {
                                            _startDate = v;
                                          },
                                          onTap: () {
                                            _ctrl.startDate.value = _startDate;
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: w(context, 8)),
                                Expanded(
                                  child: CustomLabelTextFeild(
                                    label: "Start Time",
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text:
                                          (_ctrl.startTime.value != null)
                                              ? dT.formatTimeToAMPMTakingAsDateTime(
                                                _ctrl.startTime.value!,
                                              )
                                              : '-',
                                    ),

                                    onTap: () {
                                      Get.bottomSheet(
                                        DateTimePicker(
                                          title: "Start Time",
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (v) {
                                            _startTime = v;
                                          },
                                          onTap: () {
                                            _ctrl.startTime.value = _startTime;
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: h(context, 8)),

                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: CustomLabelTextFeild(
                                    label: "End Date",
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text:
                                          (_ctrl.endDate.value != null)
                                              ? dT.getDateIsoFormat(
                                                _ctrl.endDate.value!,
                                              )
                                              : '-',
                                    ),

                                    onTap: () {
                                      Get.bottomSheet(
                                        DateTimePicker(
                                          title: "End Date",
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (v) {
                                            _endDate = v;
                                          },
                                          onTap: () {
                                            _ctrl.endDate.value = _endDate;
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: w(context, 8)),
                                Expanded(
                                  child: CustomLabelTextFeild(
                                    label: "End Time",
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text:
                                          (_ctrl.endTime.value != null)
                                              ? dT.formatTimeToAMPMTakingAsDateTime(
                                                _ctrl.endTime.value!,
                                              )
                                              : '-',
                                    ),

                                    onTap: () {
                                      Get.bottomSheet(
                                        DateTimePicker(
                                          title: "End Time",
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (v) {
                                            _endTime = v;
                                          },
                                          onTap: () {
                                            _ctrl.endTime.value = _endTime;
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h(context, 8)),
                          CustomLabelTextFeild(
                            label: "Maximum Members Allowed",
                            controller: _ctrl.maxMemberController,
                          ),
                          SizedBox(height: h(context, 8)),
                          CustomLabelTextFeild(
                            label: "Age",
                            controller: _ctrl.ageController,
                          ),
                          SizedBox(height: h(context, 8)),
                          CustomLabelTextFeild(
                            label: "Location",
                            controller: _ctrl.locationController,
                          ),
                          SizedBox(height: h(context, 8)),

                          // CustomLabelTextFeild(
                          //   label: "Category",
                          //   controller: _ctrl.categoryController,
                          // ),
                          CustomDropdownField(
                            label: "Category",
                            selectedValue: _ctrl.selectedCategory,
                            onChanged: (value) {
                              _ctrl.selectedCategory = value;
                              log("Log :: ${_ctrl.selectedCategory?.name}");
                            },
                          ),

                          SizedBox(height: h(context, 8)),
                          CustomLabelTextFeild(
                            label: "Description",
                            controller: _ctrl.descriptionController,
                            height: 139,
                            isheight: true,
                            maxLines: 5,
                          ),
                          SizedBox(height: h(context, 12)),
                          CustomButton(
                            onPressed: () {
                              // Get.offAll(HomeScreen());

                              if (_ctrl.eventSelectedImage == null) {
                                displayToast(msg: "Please add event image.");
                                return;
                              }

                              if (_ctrl.titleController.text.isEmpty) {
                                displayToast(msg: "Please add a title.");
                                return;
                              }
                              if (_ctrl.startDate.value == null) {
                                displayToast(msg: "Please add a start date.");
                                return;
                              }
                              if (_ctrl.startTime.value == null) {
                                displayToast(msg: "Please add a start time.");
                                return;
                              }
                              if (_ctrl.endDate.value == null) {
                                displayToast(msg: "Please add a end date.");
                                return;
                              }
                              if (_ctrl.endTime.value == null) {
                                displayToast(msg: "Please add a end time.");
                                return;
                              }

                              if (_ctrl.locationController.text.isEmpty) {
                                displayToast(msg: "Please add a location.");
                                return;
                              }
                              if (_ctrl.selectedCategory == null) {
                                displayToast(msg: "Please select a category.");
                                return;
                              }
                              if (_ctrl.descriptionController.text.isEmpty) {
                                displayToast(msg: "Please add a description.");
                                return;
                              }
                              if (_ctrl.maxMemberController.text.isEmpty) {
                                displayToast(msg: "Please add a max members.");
                                return;
                              }
                              if (_ctrl.ageController.text.isEmpty) {
                                displayToast(msg: "Please add a age.");
                                return;
                              }

                              _ctrl.createPlan(
                                eventImage: _ctrl.eventSelectedImage,
                              );
                            },
                            text: "Create Plan",
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
                          SizedBox(height: h(context, 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final CategoriesStatus? selectedValue;
  final ValueChanged<CategoriesStatus?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> categoryLabels = [
      "Culture and Leisure",
      "Nature and Outdoors",
      "Sports and Wellness",
      "Social and Lifestyle",
      "Creativity and Learning",
      "Travel and Getaways",
      "Gaming and Geek",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: h(context, 139),
          padding: all(context, 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(h(context, 12)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CategoriesStatus>(
              value: selectedValue,
              hint: Text(
                "Category",
                style: TextStyle(
                  fontSize: f(context, 16),
                  fontWeight: FontWeight.w500,
                  color: kBlackColor,

                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              isExpanded: true,
              items:
                  CategoriesStatus.values.map((status) {
                    final index = CategoriesStatus.values.indexOf(status);
                    return DropdownMenuItem<CategoriesStatus>(
                      value: status,
                      child: Text(
                        categoryLabels[index],
                        style: TextStyle(
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          color: kBlackColor,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
