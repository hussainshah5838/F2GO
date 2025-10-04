// import 'package:f2g/constants/app_colors.dart';
// import 'package:f2g/constants/app_fonts.dart';
// import 'package:f2g/constants/app_images.dart';
// import 'package:f2g/constants/app_styling.dart';
// import 'package:f2g/controller/auth_input_controller.dart';
// import 'package:f2g/view/screens/auth/login/login.dart';
// import 'package:f2g/view/screens/textcontrollers/textcontrollers.dart';
// import 'package:f2g/view/widget/Custom_text_widget.dart';
// import 'package:f2g/view/widget/common_image_view_widget.dart';
// import 'package:f2g/view/widget/custom_textfeild_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../widget/custom_button_widget.dart';
// import '../get_help.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   ResetPasswordScreen({super.key});

//   final TextControllers textControllers = Get.find<TextControllers>();
//   final AuthInputController authInputController = Get.put(
//     AuthInputController(),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: kPrimaryColor,
//         body: Stack(
//           children: [
//             Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
//             Positioned(
//               top: h(context, 19),
//               right: w(context, 19),
//               child: SafeArea(
//                 child: CustomText(
//                   onTap: () {
//                     Get.to(GetHelpScreen());
//                   },
//                   text: "Get Help",
//                   size: 16,
//                   weight: FontWeight.w500,
//                   color: kSecondaryColor,
//                   fontFamily: AppFonts.HelveticaNowDisplay,
//                   decoration: TextDecoration.underline,
//                   decorationColor: kSecondaryColor,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: only(context, top: 80),
//               child: Column(
//                 children: [
//                   CommonImageView(
//                     imagePath: Assets.imagesApplogo,
//                     height: 100,
//                     width: 90,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(height: h(context, 24)),
//                   CustomText(
//                     text: "Reset Password",
//                     size: 28,
//                     weight: FontWeight.w700,
//                     lineHeight: h(context, 1),
//                     fontFamily: AppFonts.HelveticaNowDisplay,
//                     color: kBlackColor,
//                     paddingBottom: 8,
//                   ),
//                   CustomText(
//                     text:
//                         "Please create your new password. Do not share\nwith anyone in your circle.",
//                     size: 14,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w500,
//                     lineHeight: h(context, 1),
//                     fontFamily: AppFonts.HelveticaNowDisplay,
//                     color: Color(0xff757575),
//                     paddingBottom: 24,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Obx(
//                             () => CustomTextfeildWidget(
//                               index: 6,
//                               hintText: "Create new password",
//                               obscureText:
//                                   authInputController
//                                       .iscreatenewpasswordvisible
//                                       .value,
//                               onTap: () {
//                                 authInputController
//                                     .toggleCreateNewPasswordVisibility();
//                               },
//                               issuffix: true,
//                               suffixicon:
//                                   authInputController
//                                           .iscreatenewpasswordvisible
//                                           .value
//                                       ? Assets.imagesSolideyedisabled
//                                       : Assets.imagesSolideye,
//                               controller:
//                                   textControllers
//                                       .createNewPasswordController
//                                       .value,
//                             ),
//                           ),
//                           SizedBox(height: h(context, 8)),
//                           Obx(
//                             () => CustomTextfeildWidget(
//                               index: 7,
//                               hintText: "Confirm new password",
//                               obscureText:
//                                   authInputController
//                                       .isconfirmnewpasswordvisible
//                                       .value,
//                               onTap: () {
//                                 authInputController
//                                     .toggleConfirmNewPasswordVisibility();
//                               },
//                               issuffix: true,
//                               suffixicon:
//                                   authInputController
//                                           .isconfirmnewpasswordvisible
//                                           .value
//                                       ? Assets.imagesSolideyedisabled
//                                       : Assets.imagesSolideye,
//                               controller:
//                                   textControllers
//                                       .confirmNewPasswordController
//                                       .value,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SafeArea(
//                     bottom: true,
//                     child: Padding(
//                       padding: symmetric(context, horizontal: 20),
//                       child: CustomButton(
//                         onPressed: () {
//                           Get.offAll(LoginScreen());
//                         },
//                         text: "Back to Login",
//                         iscustomgradient: true,
//                         gradient: LinearGradient(
//                           colors: [Color(0xff21E3D7), Color(0xffB5F985)],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderradius: 100,
//                         size: 18,
//                         weight: FontWeight.w500,
//                         fontFamily: AppFonts.HelveticaNowDisplay,
//                         color: kBlackColor,
//                         height: 50,
//                         width: double.maxFinite,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: h(context, 10)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
