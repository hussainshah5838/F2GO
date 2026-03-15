// // import 'dart:io';
// // import 'package:f2g/constants/app_colors.dart';
// // import 'package:f2g/constants/app_fonts.dart';
// // import 'package:f2g/constants/app_images.dart';
// // import 'package:f2g/constants/app_styling.dart';
// // import 'package:f2g/constants/firebase_const.dart';
// // import 'package:f2g/controller/loading_animation.dart';
// // import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
// // import 'package:f2g/core/bindings/bindings.dart';
// // import 'package:f2g/model/my_model/user_model.dart';
// // import 'package:f2g/services/date_formator/general_service.dart';
// // import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
// // import 'package:f2g/services/image_picker/image_picker.dart';
// // import 'package:f2g/services/user_profile_setup/user_profile_setup_service.dart';
// // import 'package:f2g/view/screens/Home/home_screen.dart';
// // import 'package:f2g/view/widget/Custom_text_widget.dart';
// // import 'package:f2g/view/widget/Common_image_view_widget.dart';
// // import 'package:f2g/view/widget/custom_button_widget.dart';
// // import 'package:f2g/view/widget/custom_textfeild_widget.dart';
// // import 'package:f2g/view/widget/dob_picker.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:gradient_borders/gradient_borders.dart';
// // import 'package:intl/intl.dart';

// // class CompleteProfileOnboarding extends StatefulWidget {
// //   const CompleteProfileOnboarding({super.key});

// //   @override
// //   State<CompleteProfileOnboarding> createState() =>
// //       _CompleteProfileOnboardingState();
// // }

// // class _CompleteProfileOnboardingState extends State<CompleteProfileOnboarding> {
// //   final PageController _pageController = PageController();
// //   int _currentStep = 0;

// //   // final TextEditingController _fullNameController = TextEditingController(
// //   //   text: "Christopher henry",
// //   // );
// //   // final TextEditingController _locationController = TextEditingController(
// //   //   text: "California , USA",
// //   // );
// //   // final TextEditingController _biographyController = TextEditingController(
// //   //   text: "Lorem ipsum dolor",
// //   // );
// //   // final TextEditingController _contactNameController = TextEditingController(
// //   //   text: "Chris Taylor",
// //   // );
// //   // final TextEditingController _phoneController = TextEditingController(
// //   //   text: "+1(78) 567868 5",
// //   // );

// //   bool _autoSendPlanInfo = false;
// //   // DateTime? _dob = DateTime(2022, 10, 20);

// //   // @override
// //   // void dispose() {
// //   //   _pageController.dispose();
// //   //   _fullNameController.dispose();
// //   //   _locationController.dispose();
// //   //   _biographyController.dispose();
// //   //   _contactNameController.dispose();
// //   //   _phoneController.dispose();
// //   //   super.dispose();
// //   // }

// //   void _handleBack() {
// //     if (_currentStep == 0) {
// //       Get.back();
// //       return;
// //     }
// //     _changeStep(_currentStep - 1);
// //   }

// //   Future<void> _handleConfirm() async {
// //     try {
// //       // STEP VALIDATION
// //       if (_currentStep < 2) {
// //         if (!_validateStep(_currentStep)) return;
// //         _changeStep(_currentStep + 1);
// //         return;
// //       }

// //       // FINAL STEP VALIDATION
// //       if (!_validateStep(2)) return;

// //       showLoadingDialog();

// //       final String fcm = await authCtrl.fcmToken.getToken() ?? "";
// //       final String userId = auth.currentUser!.uid;

// //       String? downloadUrl;
// //       if (authCtrl.profileImage.value != null) {
// //         downloadUrl = await FirebaseStorageService.instance.uploadImage(
// //           imagePath: authCtrl.profileImage.value!,
// //           storageFolderPath: "userProfileImages/${auth.currentUser?.uid}/",
// //         );
// //       }

// //       final success = await authCtrl.saveUserToFirestore(
// //         model: UserModel(
// //           id: userId,
// //           fullName: authCtrl.fullNameController.text.trim(),
// //           bio: authCtrl.userBioController.text.trim(),
// //           gender: authCtrl.gender.value,
// //           dob: authCtrl.dob.value,
// //           location: authCtrl.userLocationController.text.trim(),
// //           emergencyName: authCtrl.emergencyNameController.text.trim(),
// //           emergencyContactNo: authCtrl.emergencyContactNoController.text.trim(),
// //           emergencyRelation: authCtrl.emergencyPesonRelation.value!,
// //           email: auth.currentUser!.email!,
// //           fcmToken: fcm,
// //           authType: 'email',
// //           profileImage: downloadUrl ?? "",
// //           createdAt: DateTime.now(),
// //         ),
// //       );

// //       if (!success) {
// //         hideLoadingDialog();
// //         displayToast(msg: "Failed to save profile");
// //         return;
// //       }

// //       // ✅ Mark user as registered locally
// //       await userProfilleSetupSrvices.instance.checkUserProfile(userId: userId);

// //       authCtrl.clearValues();
// //       downloadUrl = null;

// //       hideLoadingDialog();

// //       // ✅ SINGLE navigation point
// //       Get.offAll(() => HomeScreen(), binding: PlanBindings());
// //     } catch (e) {
// //       hideLoadingDialog();
// //       displayToast(msg: e.toString());
// //     }
// //   }

// //   bool _validateStep(int step) {
// //     switch (step) {
// //       case 0:
// //         if (authCtrl.fullNameController.text.isEmpty) {
// //           displayToast(msg: "Please enter full name");
// //           return false;
// //         }
// //         if (authCtrl.gender.value == null) {
// //           displayToast(msg: "Please select gender");
// //           return false;
// //         }
// //         if (authCtrl.dob.value == null) {
// //           displayToast(msg: "Please select dob");
// //           return false;
// //         }
// //         return true;

// //       case 1:
// //         if (authCtrl.userLocationController.text.isEmpty) {
// //           displayToast(msg: "Please enter your address");
// //           return false;
// //         }
// //         if (authCtrl.userBioController.text.isEmpty) {
// //           displayToast(msg: "Please enter your biography");
// //           return false;
// //         }
// //         return true;

// //       case 2:
// //         if (authCtrl.emergencyNameController.text.isEmpty) {
// //           displayToast(msg: "Please enter emergency contact name");
// //           return false;
// //         }
// //         if (authCtrl.emergencyContactNoController.text.isEmpty) {
// //           displayToast(msg: "Please enter emergency contact number");
// //           return false;
// //         }
// //         if (authCtrl.emergencyPesonRelation.value == null) {
// //           displayToast(msg: "Please select emergency contact relation");
// //           return false;
// //         }
// //         return true;

// //       default:
// //         return false;
// //     }
// //   }

// //   void _changeStep(int index) {
// //     setState(() => _currentStep = index);
// //     _pageController.animateToPage(
// //       index,
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //     );
// //   }

// //   final authCtrl = Get.find<AuthInputController>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(
// //       () => Scaffold(
// //         body: GestureDetector(
// //           onTap: () => FocusScope.of(context).unfocus(),
// //           child: Container(
// //             width: double.infinity,
// //             height: double.infinity,
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage(Assets.imagesProfilebg),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //             child: SafeArea(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   SizedBox(height: h(context, 16)),
// //                   Padding(
// //                     padding: symmetric(context, horizontal: 20),
// //                     child: Row(
// //                       children: [
// //                         InkWell(
// //                           onTap: _handleBack,
// //                           child: CommonImageView(
// //                             imagePath: Assets.imagesBack,
// //                             height: 24,
// //                             width: 24,
// //                             fit: BoxFit.contain,
// //                           ),
// //                         ),
// //                         SizedBox(width: w(context, 16)),
// //                         Expanded(
// //                           child: _StepIndicator(currentStep: _currentStep),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: h(context, 18)),
// //                   Expanded(
// //                     child: PageView(
// //                       controller: _pageController,
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       children: [
// //                         _buildPersonalInfoStep(context),
// //                         _buildAdditionalInfoStep(context),
// //                         _buildEmergencyContactStep(context),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         bottomNavigationBar: Padding(
// //           padding: EdgeInsets.fromLTRB(
// //             w(context, 20),
// //             0,
// //             w(context, 20),
// //             h(context, 30),
// //           ),
// //           child: CustomButton(
// //             onPressed: _handleConfirm,
// //             text: "Confirm",
// //             borderradius: 100,
// //             size: 18,
// //             weight: FontWeight.w500,
// //             fontFamily: AppFonts.HelveticaNowDisplay,
// //             color: kBlackColor,
// //             height: 50,
// //             width: double.maxFinite,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildPersonalInfoStep(BuildContext context) {
// //     return SingleChildScrollView(
// //       padding: symmetric(context, horizontal: 20),
// //       child: GestureDetector(
// //         onTap: () => FocusScope.of(context).unfocus(),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             CustomText(
// //               text: "Personal Information",
// //               size: 24,
// //               weight: FontWeight.w700,
// //               color: kBlackColor,
// //               fontFamily: AppFonts.HelveticaNowDisplay,
// //               paddingBottom: 4,
// //             ),
// //             CustomText(
// //               text: "Please enter your personal information to move further.",
// //               size: 14,
// //               weight: FontWeight.w500,
// //               color: ktextcolor,
// //               fontFamily: AppFonts.HelveticaNowDisplay,
// //             ),
// //             SizedBox(height: h(context, 18)),
// //             GestureDetector(
// //               onTap: () => FocusScope.of(context).unfocus(),
// //               child: Container(
// //                 width: w(context, double.maxFinite),
// //                 padding: all(context, 16),
// //                 decoration: BoxDecoration(
// //                   border: GradientBoxBorder(
// //                     gradient: const LinearGradient(
// //                       colors: [Color(0xff73DAC1), Color(0xffD2F8B7)],
// //                     ),
// //                   ),
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(h(context, 14)),
// //                 ),
// //                 child: InkWell(
// //                   onTap: () async {
// //                     await ImagePickerService().pickMedia(
// //                       isImage: true,
// //                       fromGallery: true,
// //                     );
// //                     authCtrl.profileImage.value =
// //                         ImagePickerService().selectedImage.value;
// //                   },
// //                   child: Column(
// //                     children: [
// //                       // (userService.userModel.value.profileImage != null)
// //                       //               ? CommonImageView(
// //                       //                 url: userService.userModel.value.profileImage,
// //                       //                 height: 40,
// //                       //                 width: 40,
// //                       //                 radius: 100,
// //                       //                 fit: BoxFit.cover,
// //                       //               )
// //                       //               : CommonImageView(
// //                       //                 imagePath: Assets.imagesProfilepic,
// //                       //                 height: 40,
// //                       //                 width: 40,
// //                       //                 radius: 100,
// //                       //                 fit: BoxFit.cover,
// //                       //               ),
// //                       authCtrl.profileImage.value != null
// //                           ? CommonImageView(
// //                             file: File(authCtrl.profileImage.value!),
// //                             height: h(context, 96),
// //                             width: h(context, 96),
// //                             radius: h(context, 48),
// //                             fit: BoxFit.cover,
// //                           )
// //                           : Container(
// //                             height: h(context, 96),
// //                             width: h(context, 96),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: kPrimaryColor,
// //                             ),
// //                             child: const Icon(
// //                               Icons.person,
// //                               size: 38,
// //                               color: ktextcolor,
// //                             ),
// //                           ),
// //                       SizedBox(height: h(context, 12)),
// //                       CustomText(
// //                         text: "Upload Profile Photo",
// //                         size: 16,
// //                         weight: FontWeight.w500,
// //                         color: kBlackColor,
// //                         fontFamily: AppFonts.HelveticaNowDisplay,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: h(context, 20)),
// //             CustomText(
// //               text: "BASIC INFORMATION",
// //               size: 12,
// //               weight: FontWeight.w600,
// //               color: ktextcolor,
// //               fontFamily: AppFonts.HelveticaNowDisplay,
// //               paddingBottom: 12,
// //             ),
// //             _buildTextField(
// //               context,
// //               label: "Full Name",
// //               controller: authCtrl.fullNameController,
// //             ),
// //             SizedBox(height: h(context, 12)),
// //             _buildDropdownField(
// //               context,
// //               label: "Gender",
// //               value: authCtrl.gender.value ?? "Select gender",
// //               onTap:
// //                   () => _showOptionsSheet(
// //                     title: "Select Gender",
// //                     options: const ["Male", "Female", "Other"],
// //                     onSelect: (value) {
// //                       authCtrl.gender.value = value;
// //                     },
// //                   ),
// //             ),
// //             SizedBox(height: h(context, 12)),
// //             _buildDropdownField(
// //               context,
// //               label: "Date of Birth",
// //               value: authCtrl.dob.value ?? "Select dob",
// //               trailing: const Icon(Icons.calendar_today_outlined),
// //               onTap: () => _openDatePicker(context),
// //             ),
// //             SizedBox(height: h(context, 10)),
// //             CustomText(
// //               text: "You must be 18+ to use this app.",
// //               size: 12,
// //               weight: FontWeight.w500,
// //               color: const Color(0xffA80000),
// //               fontFamily: AppFonts.HelveticaNowDisplay,
// //               paddingBottom: 20,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAdditionalInfoStep(BuildContext context) {
// //     return SingleChildScrollView(
// //       padding: symmetric(context, horizontal: 20),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           CustomText(
// //             text: "Personal Information",
// //             size: 24,
// //             weight: FontWeight.w700,
// //             color: kBlackColor,
// //             fontFamily: AppFonts.HelveticaNowDisplay,
// //             paddingBottom: 4,
// //           ),
// //           CustomText(
// //             text: "Please enter your personal information to move further.",
// //             size: 14,
// //             weight: FontWeight.w500,
// //             color: ktextcolor,
// //             fontFamily: AppFonts.HelveticaNowDisplay,
// //           ),
// //           SizedBox(height: h(context, 20)),
// //           _buildTextField(
// //             context,
// //             label: "Location",
// //             controller: authCtrl.userLocationController,
// //           ),
// //           SizedBox(height: h(context, 12)),
// //           CustomLabelTextFeild(
// //             controller: authCtrl.userBioController,
// //             label: "Biography",
// //             isheight: true,
// //             height: 120,
// //             maxLines: 4,
// //           ),
// //           SizedBox(height: h(context, 14)),
// //           GestureDetector(
// //             onTap: () => setState(() => _autoSendPlanInfo = !_autoSendPlanInfo),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Checkbox(
// //                   value: _autoSendPlanInfo,
// //                   onChanged:
// //                       (value) =>
// //                           setState(() => _autoSendPlanInfo = value ?? false),
// //                   activeColor: kSecondaryColor,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(h(context, 4)),
// //                   ),
// //                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                 ),
// //                 SizedBox(width: w(context, 6)),
// //                 Expanded(
// //                   child: CustomText(
// //                     text:
// //                         "Auto-send plan info to contact when user joins a plan",
// //                     size: 14,
// //                     weight: FontWeight.w500,
// //                     color: kBlackColor,
// //                     fontFamily: AppFonts.HelveticaNowDisplay,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmergencyContactStep(BuildContext context) {
// //     return SingleChildScrollView(
// //       padding: symmetric(context, horizontal: 20),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           CustomText(
// //             text: "Emergency Contact Information",
// //             size: 24,
// //             weight: FontWeight.w700,
// //             color: kBlackColor,
// //             fontFamily: AppFonts.HelveticaNowDisplay,
// //             paddingBottom: 4,
// //           ),
// //           CustomText(
// //             text:
// //                 "Please enter your contact information in case of any emergency.",
// //             size: 14,
// //             weight: FontWeight.w500,
// //             color: ktextcolor,
// //             fontFamily: AppFonts.HelveticaNowDisplay,
// //           ),
// //           SizedBox(height: h(context, 20)),
// //           _buildTextField(
// //             context,
// //             label: "Contact Name",
// //             controller: authCtrl.emergencyNameController,
// //           ),
// //           SizedBox(height: h(context, 12)),
// //           _buildTextField(
// //             context,
// //             label: "Emergency Phone number",
// //             controller: authCtrl.emergencyContactNoController,
// //             keyboardType: TextInputType.phone,
// //           ),
// //           SizedBox(height: h(context, 12)),
// //           _buildDropdownField(
// //             context,
// //             label: "Relationship Type",
// //             value:
// //                 authCtrl.emergencyPesonRelation.value ?? "Select relationship",
// //             onTap: () {
// //               // Unfocus any text field first
// //               FocusScope.of(context).unfocus();

// //               _showOptionsSheet(
// //                 title: "Relationship Type",
// //                 options: const ["Close Friend", "Family", "Partner", "Other"],
// //                 onSelect:
// //                     (value) => setState(() {
// //                       authCtrl.emergencyPesonRelation.value = value;
// //                     }),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTextField(
// //     BuildContext context, {
// //     required String label,
// //     required TextEditingController controller,
// //     TextInputType keyboardType = TextInputType.text,
// //   }) {
// //     return CustomLabelTextFeild(
// //       controller: controller,
// //       label: label,
// //       keyboardType: keyboardType,
// //     );
// //   }

// //   Widget _buildDropdownField(
// //     BuildContext context, {
// //     required String label,
// //     required String value,
// //     VoidCallback? onTap,
// //     Widget? trailing,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: all(context, 14),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(h(context, 12)),
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   CustomText(
// //                     text: label,
// //                     size: 14,
// //                     weight: FontWeight.w500,
// //                     color: kBlackColor.withValues(alpha: 0.5),
// //                     fontFamily: AppFonts.HelveticaNowDisplay,
// //                   ),
// //                   SizedBox(height: h(context, 6)),
// //                   CustomText(
// //                     text: value,
// //                     size: 16,
// //                     weight: FontWeight.w500,
// //                     color: kBlackColor,
// //                     fontFamily: AppFonts.HelveticaNowDisplay,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             trailing ??
// //                 const Icon(Icons.keyboard_arrow_down, color: kBlackColor),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   DateTime? dob;

// //   void _openDatePicker(BuildContext context) {
// //     final int currentYear = DateTime.now().year;
// //     final int maxYear = currentYear - 18; // Must be at least 18 years old
// //     final int minYear =
// //         currentYear - 100; // Can be up to 100 years old (covers 65+)

// //     // Set initial date to someone who is 25 years old
// //     final DateTime initialDate = DateTime(currentYear - 25, 1, 1);
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (ctx) {
// //         return DateTimePicker(
// //           title: "Date of Birth",
// //           mode: CupertinoDatePickerMode.date,
// //           initialDateTime: initialDate, // 25 years ago
// //           minimumDate: minYear, // Can't be older than 100 years
// //           maximumDate: maxYear,
// //           onDateTimeChanged: (value) {
// //             setState(() {});
// //             dob = value;
// //             authCtrl.dob.value = DateTimeService.instance.getDateIsoFormat(
// //               value,
// //             );
// //           },
// //           onTap: () {
// //             if (authCtrl.dob.value == null) {
// //               authCtrl.dob.value = DateTimeService.instance.getDateIsoFormat(
// //                 initialDate,
// //               );
// //             }

// //             Get.back();
// //           },
// //         );
// //       },
// //     );
// //   }

// //   void _showOptionsSheet({
// //     required String title,
// //     required List<String> options,
// //     required ValueChanged<String> onSelect,
// //   }) {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (ctx) {
// //         return Padding(
// //           padding: EdgeInsets.fromLTRB(
// //             w(context, 20),
// //             h(context, 10),
// //             w(context, 20),
// //             h(context, 20),
// //           ),
// //           child: GestureDetector(
// //             onTap: () => FocusScope.of(context).unfocus(),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Container(
// //                   margin: EdgeInsets.only(bottom: h(context, 14)),
// //                   height: h(context, 6),
// //                   width: w(context, 60),
// //                   decoration: BoxDecoration(
// //                     color: kBlackColor.withValues(alpha: 0.1),
// //                     borderRadius: BorderRadius.circular(100),
// //                   ),
// //                 ),
// //                 CustomText(
// //                   text: title,
// //                   size: 18,
// //                   weight: FontWeight.w700,
// //                   color: kBlackColor,
// //                   fontFamily: AppFonts.HelveticaNowDisplay,
// //                   paddingBottom: 10,
// //                 ),
// //                 ...options.map(
// //                   (option) => ListTile(
// //                     dense: true,
// //                     contentPadding: EdgeInsets.zero,
// //                     title: CustomText(
// //                       text: option,
// //                       size: 16,
// //                       weight: FontWeight.w500,
// //                       color: kBlackColor,
// //                       fontFamily: AppFonts.HelveticaNowDisplay,
// //                     ),
// //                     onTap: () {
// //                       onSelect(option);
// //                       Get.back();
// //                     },
// //                   ),
// //                 ),
// //                 SizedBox(height: h(context, 6)),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // class _StepIndicator extends StatelessWidget {
// //   final int currentStep;
// //   const _StepIndicator({required this.currentStep});

// //   @override
// //   Widget build(BuildContext context) {
// //     final double progress = (currentStep + 1) / 3;
// //     return Container(
// //       height: h(context, 10),
// //       decoration: BoxDecoration(
// //         color: kWhiteColor.withValues(alpha: 0.7),
// //         borderRadius: BorderRadius.circular(h(context, 20)),
// //       ),
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return Stack(
// //             children: [
// //               Container(
// //                 height: h(context, 10),
// //                 width: constraints.maxWidth,
// //                 decoration: BoxDecoration(
// //                   color: kWhiteColor.withValues(alpha: 0.7),
// //                   borderRadius: BorderRadius.circular(h(context, 20)),
// //                 ),
// //               ),
// //               AnimatedContainer(
// //                 duration: const Duration(milliseconds: 300),
// //                 height: h(context, 10),
// //                 width: constraints.maxWidth * progress,
// //                 decoration: BoxDecoration(
// //                   gradient: const LinearGradient(
// //                     colors: [Color(0xff21E3D7), Color(0xffB5F985)],
// //                     begin: Alignment.centerLeft,
// //                     end: Alignment.centerRight,
// //                   ),
// //                   borderRadius: BorderRadius.circular(h(context, 20)),
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'dart:developer';
// import 'dart:io';
// import 'package:f2g/constants/app_colors.dart';
// import 'package:f2g/constants/app_fonts.dart';
// import 'package:f2g/constants/app_images.dart';
// import 'package:f2g/constants/app_styling.dart';
// import 'package:f2g/constants/firebase_const.dart';
// import 'package:f2g/controller/loading_animation.dart';
// import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
// import 'package:f2g/core/bindings/bindings.dart';
// import 'package:f2g/model/my_model/user_model.dart';
// import 'package:f2g/services/date_formator/general_service.dart';
// import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
// import 'package:f2g/services/image_picker/image_picker.dart';
// import 'package:f2g/services/user_profile_setup/user_profile_setup_service.dart';
// import 'package:f2g/view/screens/Home/home_screen.dart';
// import 'package:f2g/view/widget/Custom_text_widget.dart';
// import 'package:f2g/view/widget/Common_image_view_widget.dart';
// import 'package:f2g/view/widget/custom_button_widget.dart';
// import 'package:f2g/view/widget/custom_textfeild_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gradient_borders/gradient_borders.dart';

// class CompleteProfileOnboarding extends StatefulWidget {
//   const CompleteProfileOnboarding({super.key});

//   @override
//   State<CompleteProfileOnboarding> createState() =>
//       _CompleteProfileOnboardingState();
// }

// class _CompleteProfileOnboardingState extends State<CompleteProfileOnboarding>
//     with WidgetsBindingObserver {
//   final PageController _pageController = PageController();
//   int _currentStep = 0;

//   bool _autoSendPlanInfo = false;
//   DateTime? dob;

//   // Add FocusNodes to prevent auto-focus
//   final FocusNode _nameFocus = FocusNode();
//   final FocusNode _locationFocus = FocusNode();
//   final FocusNode _bioFocus = FocusNode();
//   final FocusNode _emergencyNameFocus = FocusNode();
//   final FocusNode _emergencyPhoneFocus = FocusNode();

//   final authCtrl = Get.find<AuthInputController>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _pageController.dispose();
//     _nameFocus.dispose();
//     _locationFocus.dispose();
//     _bioFocus.dispose();
//     _emergencyNameFocus.dispose();
//     _emergencyPhoneFocus.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     log('App Lifecycle State: $state');

//     // ✅ Only logout when app is KILLED/TERMINATED (not when navigating or going to background)
//     if (state == AppLifecycleState.detached) {
//       log('User killed the app - Logging out...');
//       await auth.signOut();
//     }
//   }

//   void _handleBack() {
//     if (_currentStep == 0) {
//       Get.back();
//       return;
//     }
//     _changeStep(_currentStep - 1);
//   }

//   Future<void> _handleConfirm() async {
//     try {
//       // STEP VALIDATION
//       if (_currentStep < 2) {
//         if (!_validateStep(_currentStep)) return;
//         _changeStep(_currentStep + 1);
//         return;
//       }

//       // FINAL STEP VALIDATION
//       if (!_validateStep(2)) return;

//       showLoadingDialog();

//       log("${authCtrl.profileImage.value}");

//       final String fcm = await authCtrl.fcmToken.getToken() ?? "";
//       final String userId = auth.currentUser!.uid;

//       String? downloadUrl;
//       if (authCtrl.profileImage.value != null) {
//         downloadUrl = await FirebaseStorageService.instance.uploadImage(
//           imagePath: authCtrl.profileImage.value!,
//           storageFolderPath: "userProfileImages/${auth.currentUser?.uid}/",
//         );
//       }

//       final success = await authCtrl.saveUserToFirestore(
//         model: UserModel(
//           id: userId,
//           fullName: authCtrl.fullNameController.text.trim(),
//           bio: authCtrl.userBioController.text.trim(),
//           gender: authCtrl.gender.value,
//           dob: authCtrl.dob.value,
//           location: authCtrl.userLocationController.text.trim(),
//           emergencyName: authCtrl.emergencyNameController.text.trim(),
//           emergencyContactNo: authCtrl.emergencyContactNoController.text.trim(),
//           emergencyRelation: authCtrl.emergencyPesonRelation.value!,
//           email: auth.currentUser!.email!,
//           fcmToken: fcm,
//           authType: 'email',
//           profileImage: downloadUrl ?? "",
//           createdAt: DateTime.now(),
//         ),
//       );

//       if (!success) {
//         hideLoadingDialog();
//         displayToast(msg: "Failed to save profile");
//         return;
//       }

//       // ✅ Mark user as registered locally
//       await userProfilleSetupSrvices.instance.checkUserProfile(userId: userId);

//       authCtrl.clearValues();
//       downloadUrl = null;

//       hideLoadingDialog();

//       // ✅ SINGLE navigation point
//       Get.offAll(() => HomeScreen(), binding: PlanBindings());
//     } catch (e) {
//       hideLoadingDialog();
//       displayToast(msg: e.toString());
//     }
//   }

//   bool _validateStep(int step) {
//     switch (step) {
//       case 0:
//         if (authCtrl.fullNameController.text.isEmpty) {
//           displayToast(msg: "Please enter full name");
//           return false;
//         }
//         if (authCtrl.gender.value == null) {
//           displayToast(msg: "Please select gender");
//           return false;
//         }
//         if (authCtrl.dob.value == null) {
//           displayToast(msg: "Please select dob");
//           return false;
//         }
//         return true;

//       case 1:
//         if (authCtrl.userLocationController.text.isEmpty) {
//           displayToast(msg: "Please enter your address");
//           return false;
//         }
//         if (authCtrl.userBioController.text.isEmpty) {
//           displayToast(msg: "Please enter your biography");
//           return false;
//         }
//         return true;

//       case 2:
//         if (authCtrl.emergencyNameController.text.isEmpty) {
//           displayToast(msg: "Please enter emergency contact name");
//           return false;
//         }
//         if (authCtrl.emergencyContactNoController.text.isEmpty) {
//           displayToast(msg: "Please enter emergency contact number");
//           return false;
//         }
//         if (authCtrl.emergencyPesonRelation.value == null) {
//           displayToast(msg: "Please select emergency contact relation");
//           return false;
//         }
//         return true;

//       default:
//         return false;
//     }
//   }

//   void _changeStep(int index) {
//     // Unfocus all fields when changing steps
//     _unfocusAll();

//     setState(() => _currentStep = index);
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   // Helper method to unfocus all fields
//   void _unfocusAll() {
//     FocusScope.of(context).unfocus();
//     _nameFocus.unfocus();
//     _locationFocus.unfocus();
//     _bioFocus.unfocus();
//     _emergencyNameFocus.unfocus();
//     _emergencyPhoneFocus.unfocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => WillPopScope(
//         onWillPop: () async {
//           await auth.signOut(); // logout
//           return true; // allow back navigation
//         },
//         child: Scaffold(
//           body: GestureDetector(
//             onTap: () => _unfocusAll(),
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(Assets.imagesProfilebg),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: h(context, 16)),
//                     Padding(
//                       padding: symmetric(context, horizontal: 20),
//                       child: Row(
//                         children: [
//                           InkWell(
//                             onTap: _handleBack,
//                             child: CommonImageView(
//                               imagePath: Assets.imagesBack,
//                               height: 24,
//                               width: 24,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           SizedBox(width: w(context, 16)),
//                           Expanded(
//                             child: _StepIndicator(currentStep: _currentStep),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: h(context, 18)),
//                     Expanded(
//                       child: PageView(
//                         controller: _pageController,
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: [
//                           _buildPersonalInfoStep(context),
//                           _buildAdditionalInfoStep(context),
//                           _buildEmergencyContactStep(context),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           bottomNavigationBar: Padding(
//             padding: EdgeInsets.fromLTRB(
//               w(context, 20),
//               0,
//               w(context, 20),
//               h(context, 30),
//             ),
//             child: CustomButton(
//               onPressed: _handleConfirm,
//               text: "Confirm",
//               borderradius: 100,
//               size: 18,
//               weight: FontWeight.w500,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               color: kBlackColor,
//               height: 50,
//               width: double.maxFinite,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonalInfoStep(BuildContext context) {
//     return SingleChildScrollView(
//       padding: symmetric(context, horizontal: 20),
//       child: GestureDetector(
//         onTap: () => _unfocusAll(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: "Personal Information",
//               size: 24,
//               weight: FontWeight.w700,
//               color: kBlackColor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 4,
//             ),
//             CustomText(
//               text: "Please enter your personal information to move further.",
//               size: 14,
//               weight: FontWeight.w500,
//               color: ktextcolor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//             ),
//             SizedBox(height: h(context, 18)),
//             GestureDetector(
//               onTap: () => _unfocusAll(),
//               child: Container(
//                 width: w(context, double.maxFinite),
//                 padding: all(context, 16),
//                 decoration: BoxDecoration(
//                   border: GradientBoxBorder(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xff73DAC1), Color(0xffD2F8B7)],
//                     ),
//                   ),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(h(context, 14)),
//                 ),
//                 child: InkWell(
//                   onTap: () async {
//                     _unfocusAll();
//                     await Future.delayed(const Duration(milliseconds: 150));

//                     await ImagePickerService().pickMedia(
//                       isImage: true,
//                       fromGallery: true,
//                     );
//                     authCtrl.profileImage.value =
//                         ImagePickerService().selectedImage.value;
//                   },
//                   child: Column(
//                     children: [
//                       authCtrl.profileImage.value != null
//                           ? CommonImageView(
//                             file: File(authCtrl.profileImage.value!),
//                             height: h(context, 96),
//                             width: h(context, 110),
//                             radius: h(context, 48),
//                             fit: BoxFit.cover,
//                           )
//                           : Container(
//                             height: h(context, 96),
//                             width: h(context, 96),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: kPrimaryColor,
//                             ),
//                             child: const Icon(
//                               Icons.person,
//                               size: 38,
//                               color: ktextcolor,
//                             ),
//                           ),
//                       SizedBox(height: h(context, 12)),
//                       CustomText(
//                         text: "Upload Profile Photo",
//                         size: 16,
//                         weight: FontWeight.w500,
//                         color: kBlackColor,
//                         fontFamily: AppFonts.HelveticaNowDisplay,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: h(context, 20)),
//             CustomText(
//               text: "BASIC INFORMATION",
//               size: 12,
//               weight: FontWeight.w600,
//               color: ktextcolor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 12,
//             ),
//             _buildTextField(
//               context,
//               label: "Full Name",
//               controller: authCtrl.fullNameController,
//               focusNode: _nameFocus,
//             ),
//             SizedBox(height: h(context, 12)),
//             _buildDropdownField(
//               context,
//               label: "Gender",
//               value: authCtrl.gender.value ?? "Select gender",
//               onTap:
//                   () => _showOptionsSheet(
//                     title: "Select Gender",
//                     options: const ["Male", "Female", "Other"],
//                     onSelect: (value) {
//                       authCtrl.gender.value = value;
//                     },
//                   ),
//             ),
//             SizedBox(height: h(context, 12)),
//             _buildDropdownField(
//               context,
//               label: "Date of Birth",
//               value: authCtrl.dob.value ?? "Select dob",
//               trailing: const Icon(Icons.calendar_today_outlined),
//               onTap: () => _openDatePicker(context),
//             ),
//             SizedBox(height: h(context, 10)),
//             CustomText(
//               text: "You must be 18+ to use this app.",
//               size: 12,
//               weight: FontWeight.w500,
//               color: const Color(0xffA80000),
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAdditionalInfoStep(BuildContext context) {
//     return SingleChildScrollView(
//       padding: symmetric(context, horizontal: 20),
//       child: GestureDetector(
//         onTap: () => _unfocusAll(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: "Personal Information",
//               size: 24,
//               weight: FontWeight.w700,
//               color: kBlackColor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 4,
//             ),
//             CustomText(
//               text: "Please enter your personal information to move further.",
//               size: 14,
//               weight: FontWeight.w500,
//               color: ktextcolor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//             ),
//             SizedBox(height: h(context, 20)),
//             _buildTextField(
//               context,
//               label: "Location",
//               controller: authCtrl.userLocationController,
//               focusNode: _locationFocus,
//             ),
//             SizedBox(height: h(context, 12)),
//             CustomLabelTextFeild(
//               controller: authCtrl.userBioController,
//               label: "Biography",
//               isheight: true,
//               height: 120,
//               maxLines: 4,
//               focusNode: _bioFocus,
//             ),
//             SizedBox(height: h(context, 14)),
//             GestureDetector(
//               onTap: () {
//                 _unfocusAll();
//                 setState(() => _autoSendPlanInfo = !_autoSendPlanInfo);
//               },
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _autoSendPlanInfo,
//                     onChanged: (value) {
//                       _unfocusAll();
//                       setState(() => _autoSendPlanInfo = value ?? false);
//                     },
//                     activeColor: kSecondaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(h(context, 4)),
//                     ),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   ),
//                   SizedBox(width: w(context, 6)),
//                   Expanded(
//                     child: CustomText(
//                       text:
//                           "Auto-send plan info to contact when user joins a plan",
//                       size: 14,
//                       weight: FontWeight.w500,
//                       color: kBlackColor,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmergencyContactStep(BuildContext context) {
//     return SingleChildScrollView(
//       padding: symmetric(context, horizontal: 20),
//       child: GestureDetector(
//         onTap: () => _unfocusAll(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: "Emergency Contact Information",
//               size: 24,
//               weight: FontWeight.w700,
//               color: kBlackColor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 4,
//             ),
//             CustomText(
//               text:
//                   "Please enter your contact information in case of any emergency.",
//               size: 14,
//               weight: FontWeight.w500,
//               color: ktextcolor,
//               fontFamily: AppFonts.HelveticaNowDisplay,
//             ),
//             SizedBox(height: h(context, 20)),
//             _buildTextField(
//               context,
//               label: "Contact Name",
//               controller: authCtrl.emergencyNameController,
//               focusNode: _emergencyNameFocus,
//             ),
//             SizedBox(height: h(context, 12)),
//             _buildTextField(
//               context,
//               label: "Emergency Phone number",
//               controller: authCtrl.emergencyContactNoController,
//               keyboardType: TextInputType.phone,
//               focusNode: _emergencyPhoneFocus,
//             ),
//             SizedBox(height: h(context, 12)),
//             _buildDropdownField(
//               context,
//               label: "Relationship Type",
//               value:
//                   authCtrl.emergencyPesonRelation.value ??
//                   "Select relationship",
//               onTap: () {
//                 _showOptionsSheet(
//                   title: "Relationship Type",
//                   options: const ["Close Friend", "Family", "Partner", "Other"],
//                   onSelect: (value) {
//                     authCtrl.emergencyPesonRelation.value = value;
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     BuildContext context, {
//     required String label,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     FocusNode? focusNode,
//   }) {
//     return CustomLabelTextFeild(
//       controller: controller,
//       label: label,
//       keyboardType: keyboardType,
//       focusNode: focusNode,
//     );
//   }

//   Widget _buildDropdownField(
//     BuildContext context, {
//     required String label,
//     required String value,
//     VoidCallback? onTap,
//     Widget? trailing,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         // CRITICAL: Unfocus ALL fields before opening dropdown
//         _unfocusAll();

//         // Small delay to ensure keyboard is dismissed
//         Future.delayed(const Duration(milliseconds: 150), () {
//           if (onTap != null) onTap();
//         });
//       },
//       child: AbsorbPointer(
//         child: Container(
//           padding: all(context, 14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(h(context, 12)),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: label,
//                       size: 14,
//                       weight: FontWeight.w500,
//                       color: kBlackColor.withValues(alpha: 0.5),
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                     SizedBox(height: h(context, 6)),
//                     CustomText(
//                       text: value,
//                       size: 16,
//                       weight: FontWeight.w500,
//                       color: kBlackColor,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                   ],
//                 ),
//               ),
//               trailing ??
//                   const Icon(Icons.keyboard_arrow_down, color: kBlackColor),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _openDatePicker(BuildContext context) {
//     // Unfocus everything first
//     _unfocusAll();

//     Future.delayed(const Duration(milliseconds: 200), () {
//       final DateTime now = DateTime.now();

//       // Maximum date: exactly 18 years ago from today
//       final DateTime maximumDate = DateTime(now.year - 18, now.month, now.day);

//       // Minimum date: 100 years ago
//       final DateTime minimumDate = DateTime(now.year - 100, 1, 1);

//       // Initial date: exactly 18 years ago
//       DateTime selectedDate = maximumDate;

//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         builder: (ctx) {
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//             ),
//             child: Column(
//               children: [
//                 // Header
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () => Get.back(),
//                         child: Text('Cancel'),
//                       ),
//                       Text(
//                         'Date of Birth',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Validate age before confirming
//                           if (_isAtLeast18YearsOld(selectedDate)) {
//                             setState(() {
//                               dob = selectedDate;
//                             });
//                             authCtrl.dob.value = DateTimeService.instance
//                                 .getDateIsoFormat(selectedDate);
//                             Get.back();
//                           } else {
//                             // Show error message
//                             Get.snackbar(
//                               'Invalid Age',
//                               'You must be at least 18 years old to create an account.',
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: Colors.red,
//                               colorText: Colors.white,
//                             );
//                           }
//                         },
//                         child: Text('Done'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(height: 1),

//                 // Date Picker
//                 Expanded(
//                   child: CupertinoDatePicker(
//                     mode: CupertinoDatePickerMode.date,
//                     initialDateTime: selectedDate,
//                     minimumDate: minimumDate,
//                     maximumDate: maximumDate,
//                     onDateTimeChanged: (value) {
//                       selectedDate = value;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ).then((_) {
//         Future.delayed(const Duration(milliseconds: 100), () {
//           _unfocusAll();
//         });
//       });
//     });
//   }

//   // Helper method to check if user is at least 18 years old
//   bool _isAtLeast18YearsOld(DateTime birthDate) {
//     final DateTime now = DateTime.now();
//     final DateTime eighteenYearsAgo = DateTime(
//       now.year - 18,
//       now.month,
//       now.day,
//     );

//     // Birth date must be on or before the date 18 years ago
//     return birthDate.isBefore(eighteenYearsAgo) ||
//         birthDate.isAtSameMomentAs(eighteenYearsAgo);
//   }

//   // void _openDatePicker(BuildContext context) {
//   //   // Unfocus everything first
//   //   _unfocusAll();

//   //   Future.delayed(const Duration(milliseconds: 200), () {
//   //     final int currentYear = DateTime.now().year;
//   //     final int maxYear = currentYear - 18; // Must be at least 18 years old
//   //     final int minYear =
//   //         currentYear - 100; // Can be up to 100 years old (covers 65+)

//   //     // Set initial date to someone who is 25 years old
//   //     final DateTime initialDate = DateTime(currentYear - 25, 1, 1);

//   //     showModalBottomSheet(
//   //       context: context,
//   //       isScrollControlled: true,
//   //       backgroundColor: Colors.transparent,
//   //       builder: (ctx) {
//   //         return DateTimePicker(
//   //           title: "Date of Birth",
//   //           mode: CupertinoDatePickerMode.date,
//   //           initialDateTime: initialDate, // 25 years ago
//   //           minimumDate: minYear, // Can't be older than 100 years
//   //           maximumDate: maxYear,
//   //           onDateTimeChanged: (value) {
//   //             setState(() {});
//   //             dob = value;
//   //             authCtrl.dob.value = DateTimeService.instance.getDateIsoFormat(
//   //               value,
//   //             );
//   //           },
//   //           onTap: () {
//   //             if (authCtrl.dob.value == null) {
//   //               authCtrl.dob.value = DateTimeService.instance.getDateIsoFormat(
//   //                 initialDate,
//   //               );
//   //             }
//   //             Get.back();
//   //           },
//   //         );
//   //       },
//   //     ).then((_) {
//   //       // Ensure keyboard stays hidden after bottom sheet closes
//   //       Future.delayed(const Duration(milliseconds: 100), () {
//   //         _unfocusAll();
//   //       });
//   //     });
//   //   });
//   // }

//   void _showOptionsSheet({
//     required String title,
//     required List<String> options,
//     required ValueChanged<String> onSelect,
//   }) {
//     // Unfocus everything before showing sheet
//     _unfocusAll();

//     Future.delayed(const Duration(milliseconds: 200), () {
//       showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (ctx) {
//           return Padding(
//             padding: EdgeInsets.fromLTRB(
//               w(context, 20),
//               h(context, 10),
//               w(context, 20),
//               h(context, 20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: h(context, 14)),
//                   height: h(context, 6),
//                   width: w(context, 60),
//                   decoration: BoxDecoration(
//                     color: kBlackColor.withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                 ),
//                 CustomText(
//                   text: title,
//                   size: 18,
//                   weight: FontWeight.w700,
//                   color: kBlackColor,
//                   fontFamily: AppFonts.HelveticaNowDisplay,
//                   paddingBottom: 10,
//                 ),
//                 ...options.map(
//                   (option) => ListTile(
//                     dense: true,
//                     contentPadding: EdgeInsets.zero,
//                     title: CustomText(
//                       text: option,
//                       size: 16,
//                       weight: FontWeight.w500,
//                       color: kBlackColor,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                     onTap: () {
//                       onSelect(option);
//                       Get.back();
//                     },
//                   ),
//                 ),
//                 SizedBox(height: h(context, 6)),
//               ],
//             ),
//           );
//         },
//       ).then((_) {
//         // Ensure keyboard stays hidden after bottom sheet closes
//         Future.delayed(const Duration(milliseconds: 100), () {
//           _unfocusAll();
//         });
//       });
//     });
//   }
// }

// class _StepIndicator extends StatelessWidget {
//   final int currentStep;
//   const _StepIndicator({required this.currentStep});

//   @override
//   Widget build(BuildContext context) {
//     final double progress = (currentStep + 1) / 3;
//     return Container(
//       height: h(context, 10),
//       decoration: BoxDecoration(
//         color: kWhiteColor.withValues(alpha: 0.7),
//         borderRadius: BorderRadius.circular(h(context, 20)),
//       ),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Stack(
//             children: [
//               Container(
//                 height: h(context, 10),
//                 width: constraints.maxWidth,
//                 decoration: BoxDecoration(
//                   color: kWhiteColor.withValues(alpha: 0.7),
//                   borderRadius: BorderRadius.circular(h(context, 20)),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 height: h(context, 10),
//                 width: constraints.maxWidth * progress,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xff21E3D7), Color(0xffB5F985)],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(h(context, 20)),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:f2g/services/date_formator/general_service.dart';
import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
import 'package:f2g/services/image_picker/image_picker.dart';
import 'package:f2g/services/user_profile_setup/user_profile_setup_service.dart';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/Common_image_view_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:f2g/view/widget/custom_textfeild_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CompleteProfileOnboarding extends StatefulWidget {
  const CompleteProfileOnboarding({super.key});

  @override
  State<CompleteProfileOnboarding> createState() =>
      _CompleteProfileOnboardingState();
}

class _CompleteProfileOnboardingState extends State<CompleteProfileOnboarding>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  bool _autoSendPlanInfo = false;
  DateTime? dob;

  // Add FocusNodes to prevent auto-focus
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _emergencyNameFocus = FocusNode();
  final FocusNode _emergencyPhoneFocus = FocusNode();

  final authCtrl = Get.find<AuthInputController>();

  // ✅ Helper to get total steps based on checkbox
  int get _totalSteps => _autoSendPlanInfo ? 3 : 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _nameFocus.dispose();
    _locationFocus.dispose();
    _bioFocus.dispose();
    _emergencyNameFocus.dispose();
    _emergencyPhoneFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    log('App Lifecycle State: $state');

    // ✅ Only logout when app is KILLED/TERMINATED
    if (state == AppLifecycleState.detached) {
      log('User killed the app - Logging out...');
      await auth.signOut();
    }
  }

  void _handleBack() {
    if (_currentStep == 0) {
      Get.back();
      return;
    }
    _changeStep(_currentStep - 1);
  }

  Future<void> _handleConfirm() async {
    try {
      // ✅ Check if we're on the last step
      final isLastStep = _currentStep == _totalSteps - 1;

      // if (!isLastStep) {
      //   // Validate current step and move to next
      //   if (!_validateStep(_currentStep)) return;
      //   _changeStep(_currentStep + 1);
      //   return;
      // }
      if (!isLastStep) {
        if (!_validateStep(_currentStep)) return;

        // ✅ If on step 0, run face detection before moving forward
        if (_currentStep == 0) {
          final isFace = await authCtrl.detectFaceInImage(
            authCtrl.profileImage.value!,
          );
          if (!isFace) return; // toast & null already handled inside function
        }

        _changeStep(_currentStep + 1);
        return;
      }

      // ✅ FINAL STEP - Validate and save
      if (!_validateStep(_currentStep)) return;

      showLoadingDialog();

      log("Profile Image: ${authCtrl.profileImage.value}");

      final String fcm = await authCtrl.fcmToken.getToken() ?? "";
      final String userId = auth.currentUser!.uid;

      String? downloadUrl;

      if (authCtrl.profileImage.value != null) {
        downloadUrl = await FirebaseStorageService.instance.uploadImage(
          imagePath: authCtrl.profileImage.value!,
          storageFolderPath: "userProfileImages/$userId/",
        );
      }

      // ✅ If emergency contact is skipped, use empty strings
      final emergencyName =
          _autoSendPlanInfo ? authCtrl.emergencyNameController.text.trim() : "";
      final emergencyPhone =
          _autoSendPlanInfo
              ? authCtrl.emergencyContactNoController.text.trim()
              : "";
      final emergencyRelation =
          _autoSendPlanInfo
              ? (authCtrl.emergencyPesonRelation.value ?? "")
              : "";

      final success = await authCtrl.saveUserToFirestore(
        // uid: userId,
        model: UserModel(
          id: userId,
          fullName: authCtrl.fullNameController.text.trim(),
          bio:
              authCtrl.userBioController.text.trim().isEmpty
                  ? ''
                  : authCtrl.userBioController.text.trim(),
          gender: authCtrl.gender.value,
          dob: authCtrl.dob.value,
          location: authCtrl.userLocationController.text.trim(),
          emergencyName: emergencyName,
          emergencyContactNo: emergencyPhone,
          emergencyRelation: emergencyRelation,
          email: auth.currentUser!.email!,
          fcmToken: fcm,
          authType: 'email',
          profileImage: downloadUrl ?? "",
          createdAt: DateTime.now(),
        ),
      );

      if (!success) {
        hideLoadingDialog();
        displayToast(msg: "Failed to save profile");
        return;
      }

      // ✅ Mark user as registered locally
      await userProfilleSetupSrvices.instance.checkUserProfile(userId: userId);

      authCtrl.clearValues();
      downloadUrl = null;

      hideLoadingDialog();

      // ✅ SINGLE navigation point
      Get.offAll(() => HomeScreen(), binding: PlanBindings());
    } catch (e) {
      hideLoadingDialog();
      log("Error in _handleConfirm: $e");
      displayToast(msg: e.toString());
    }
  }

  bool _validateStep(int step) {
    switch (step) {
      case 0:
        if (authCtrl.profileImage.value == null) {
          displayToast(msg: "Please upload your profile image");
          return false;
        }

        if (authCtrl.fullNameController.text.isEmpty) {
          displayToast(msg: "Please enter full name");
          return false;
        }
        if (authCtrl.gender.value == null) {
          displayToast(msg: "Please select gender");
          return false;
        }
        if (authCtrl.dob.value == null) {
          displayToast(msg: "Please select dob");
          return false;
        }
        return true;

      case 1:
        if (authCtrl.userLocationController.text.isEmpty) {
          displayToast(msg: "Please enter your address");
          return false;
        }
        // if (authCtrl.userBioController.text.isEmpty) {
        //   displayToast(msg: "Please enter your biography");
        //   return false;
        // }
        return true;

      case 2:
        // ✅ Only validate if emergency contact is required
        if (_autoSendPlanInfo) {
          if (authCtrl.emergencyNameController.text.isEmpty) {
            displayToast(msg: "Please enter emergency contact name");
            return false;
          }
          if (authCtrl.emergencyContactNoController.text.isEmpty) {
            displayToast(msg: "Please enter emergency contact number");
            return false;
          }
          if (authCtrl.emergencyPesonRelation.value == null) {
            displayToast(msg: "Please select emergency contact relation");
            return false;
          }
        }
        return true;

      default:
        return false;
    }
  }

  void _changeStep(int index) {
    _unfocusAll();
    setState(() => _currentStep = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Helper method to unfocus all fields
  void _unfocusAll() {
    FocusScope.of(context).unfocus();
    _nameFocus.unfocus();
    _locationFocus.unfocus();
    _bioFocus.unfocus();
    _emergencyNameFocus.unfocus();
    _emergencyPhoneFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          await auth.signOut(); // logout
          return true; // allow back navigation
        },
        child: Scaffold(
          body: GestureDetector(
            onTap: () => _unfocusAll(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesProfilebg),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h(context, 16)),
                    Padding(
                      padding: symmetric(context, horizontal: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: _handleBack,
                            child: CommonImageView(
                              imagePath: Assets.imagesBack,
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: w(context, 16)),
                          Expanded(
                            // ✅ Updated to use dynamic total steps
                            child: _StepIndicator(
                              currentStep: _currentStep,
                              totalSteps: _totalSteps,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h(context, 18)),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildPersonalInfoStep(context),
                          _buildAdditionalInfoStep(context),
                          // ✅ Only show emergency contact if checkbox is true
                          if (_autoSendPlanInfo)
                            _buildEmergencyContactStep(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              w(context, 20),
              0,
              w(context, 20),
              h(context, 30),
            ),
            child: CustomButton(
              onPressed: _handleConfirm,
              text: "Confirm",
              borderradius: 100,
              size: 18,
              weight: FontWeight.w500,
              fontFamily: AppFonts.HelveticaNowDisplay,
              color: kBlackColor,
              height: 50,
              width: double.maxFinite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep(BuildContext context) {
    return SingleChildScrollView(
      padding: symmetric(context, horizontal: 20),
      child: GestureDetector(
        onTap: () => _unfocusAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Personal Information",
              size: 24,
              weight: FontWeight.w700,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 4,
            ),
            CustomText(
              text: "Please enter your personal information to move further.",
              size: 14,
              weight: FontWeight.w500,
              color: ktextcolor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: h(context, 18)),
            GestureDetector(
              onTap: () => _unfocusAll(),
              child: Container(
                width: w(context, double.maxFinite),
                padding: all(context, 16),
                decoration: BoxDecoration(
                  border: GradientBoxBorder(
                    gradient: const LinearGradient(
                      colors: [Color(0xff73DAC1), Color(0xffD2F8B7)],
                    ),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(h(context, 14)),
                ),
                child: InkWell(
                  onTap: () async {
                    _unfocusAll();
                    await Future.delayed(const Duration(milliseconds: 150));

                    await ImagePickerService().pickMedia(
                      isImage: true,
                      fromGallery: true,
                    );
                    authCtrl.profileImage.value =
                        ImagePickerService().selectedImage.value;
                  },
                  child: Column(
                    children: [
                      authCtrl.profileImage.value != null
                          ? CommonImageView(
                            file: File(authCtrl.profileImage.value!),
                            height: h(context, 96),
                            width: h(context, 96),
                            radius: h(context, 48),
                            fit: BoxFit.cover,
                          )
                          : Container(
                            height: h(context, 96),
                            width: h(context, 96),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 38,
                              color: ktextcolor,
                            ),
                          ),
                      SizedBox(height: h(context, 12)),
                      CustomText(
                        text: "Upload Profile Photo",
                        size: 16,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                      CustomText(
                        paddingTop: 5,
                        paddingBottom: 5,
                        text: "Please upload a real photo of yourself.",
                        size: 12,
                        weight: FontWeight.w400,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: "BASIC INFORMATION",
              size: 12,
              weight: FontWeight.w600,
              color: ktextcolor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 12,
            ),
            _buildTextField(
              context,
              label: "Full Name",
              controller: authCtrl.fullNameController,
              focusNode: _nameFocus,
            ),
            SizedBox(height: h(context, 12)),
            _buildDropdownField(
              context,
              label: "Gender",
              value: authCtrl.gender.value ?? "Select gender",
              onTap:
                  () => _showOptionsSheet(
                    title: "Select Gender",
                    options: const ["Male", "Female", "Other"],
                    onSelect: (value) {
                      authCtrl.gender.value = value;
                    },
                  ),
            ),
            SizedBox(height: h(context, 12)),
            _buildDropdownField(
              context,
              label: "Date of Birth",
              value: authCtrl.dob.value ?? "Select dob",
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: () => _openDatePicker(context),
            ),
            SizedBox(height: h(context, 10)),
            CustomText(
              text: "You must be 18+ to use this app.",
              size: 12,
              weight: FontWeight.w500,
              color: const Color(0xffA80000),
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoStep(BuildContext context) {
    return SingleChildScrollView(
      padding: symmetric(context, horizontal: 20),
      child: GestureDetector(
        onTap: () => _unfocusAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Personal Information",
              size: 24,
              weight: FontWeight.w700,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 4,
            ),
            CustomText(
              text: "Please enter your personal information to move further.",
              size: 14,
              weight: FontWeight.w500,
              color: ktextcolor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: h(context, 20)),
            _buildTextField(
              context,
              label: "Location",
              controller: authCtrl.userLocationController,
              focusNode: _locationFocus,
            ),
            SizedBox(height: h(context, 12)),
            CustomLabelTextFeild(
              controller: authCtrl.userBioController,
              label: "Biography",
              isheight: true,
              height: 120,
              maxLines: 4,
              focusNode: _bioFocus,
            ),
            SizedBox(height: h(context, 14)),
            GestureDetector(
              onTap: () {
                _unfocusAll();
                setState(() => _autoSendPlanInfo = !_autoSendPlanInfo);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _autoSendPlanInfo,
                    onChanged: (value) {
                      _unfocusAll();
                      setState(() => _autoSendPlanInfo = value ?? false);
                    },
                    activeColor: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(h(context, 4)),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  SizedBox(width: w(context, 6)),
                  Expanded(
                    child: CustomText(
                      text:
                          "Auto-send plan info to contact when user joins a plan",
                      size: 14,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactStep(BuildContext context) {
    return SingleChildScrollView(
      padding: symmetric(context, horizontal: 20),
      child: GestureDetector(
        onTap: () => _unfocusAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Emergency Contact Information",
              size: 24,
              weight: FontWeight.w700,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              paddingBottom: 4,
            ),
            CustomText(
              text:
                  "Please enter your contact information in case of any emergency.",
              size: 14,
              weight: FontWeight.w500,
              color: ktextcolor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: h(context, 20)),
            _buildTextField(
              context,
              label: "Contact Name",
              controller: authCtrl.emergencyNameController,
              focusNode: _emergencyNameFocus,
            ),
            SizedBox(height: h(context, 12)),
            _buildTextField(
              context,
              label: "Emergency Phone number",
              controller: authCtrl.emergencyContactNoController,
              keyboardType: TextInputType.phone,
              focusNode: _emergencyPhoneFocus,
            ),
            SizedBox(height: h(context, 12)),
            _buildDropdownField(
              context,
              label: "Relationship Type",
              value:
                  authCtrl.emergencyPesonRelation.value ??
                  "Select relationship",
              onTap: () {
                _showOptionsSheet(
                  title: "Relationship Type",
                  options: const ["Close Friend", "Family", "Partner", "Other"],
                  onSelect: (value) {
                    authCtrl.emergencyPesonRelation.value = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode,
  }) {
    return CustomLabelTextFeild(
      controller: controller,
      label: label,
      keyboardType: keyboardType,
      focusNode: focusNode,
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    required String value,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: () {
        _unfocusAll();
        Future.delayed(const Duration(milliseconds: 150), () {
          if (onTap != null) onTap();
        });
      },
      child: AbsorbPointer(
        child: Container(
          padding: all(context, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(h(context, 12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: label,
                      size: 14,
                      weight: FontWeight.w500,
                      color: kBlackColor.withValues(alpha: 0.5),
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                    SizedBox(height: h(context, 6)),
                    CustomText(
                      text: value,
                      size: 16,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ],
                ),
              ),
              trailing ??
                  const Icon(Icons.keyboard_arrow_down, color: kBlackColor),
            ],
          ),
        ),
      ),
    );
  }

  void _openDatePicker(BuildContext context) {
    _unfocusAll();

    Future.delayed(const Duration(milliseconds: 200), () {
      final DateTime now = DateTime.now();
      final DateTime maximumDate = DateTime(now.year - 18, now.month, now.day);
      final DateTime minimumDate = DateTime(now.year - 100, 1, 1);
      DateTime selectedDate = maximumDate;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('Cancel'),
                      ),
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_isAtLeast18YearsOld(selectedDate)) {
                            setState(() {
                              dob = selectedDate;
                            });
                            authCtrl.dob.value = DateTimeService.instance
                                .getDateIsoFormat(selectedDate);
                            Get.back();
                          } else {
                            Get.snackbar(
                              'Invalid Age',
                              'You must be at least 18 years old to create an account.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: Text('Done'),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    onDateTimeChanged: (value) {
                      selectedDate = value;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _unfocusAll();
        });
      });
    });
  }

  bool _isAtLeast18YearsOld(DateTime birthDate) {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );
    return birthDate.isBefore(eighteenYearsAgo) ||
        birthDate.isAtSameMomentAs(eighteenYearsAgo);
  }

  void _showOptionsSheet({
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelect,
  }) {
    _unfocusAll();

    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              w(context, 20),
              h(context, 10),
              w(context, 20),
              h(context, 20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: h(context, 14)),
                  height: h(context, 6),
                  width: w(context, 60),
                  decoration: BoxDecoration(
                    color: kBlackColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                CustomText(
                  text: title,
                  size: 18,
                  weight: FontWeight.w700,
                  color: kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                  paddingBottom: 10,
                ),
                ...options.map(
                  (option) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: CustomText(
                      text: option,
                      size: 16,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                    onTap: () {
                      onSelect(option);
                      Get.back();
                    },
                  ),
                ),
                SizedBox(height: h(context, 6)),
              ],
            ),
          );
        },
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _unfocusAll();
        });
      });
    });
  }
}

// ✅ Updated StepIndicator to accept totalSteps
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    final double progress = (currentStep + 1) / totalSteps;
    return Container(
      height: h(context, 10),
      decoration: BoxDecoration(
        color: kWhiteColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(h(context, 20)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: h(context, 10),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: kWhiteColor.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(h(context, 20)),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: h(context, 10),
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff21E3D7), Color(0xffB5F985)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(h(context, 20)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
