import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/plans/chat_screen.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/disable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../widget/custom_button_widget.dart';

// class DetailsController extends GetxController {
//   RxInt currentIndex = 0.obs;
//   PageController pageController = PageController();

//   void onPageChanged(int index) {
//     currentIndex.value = index;
//   }
// }

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // final _controller = Get.put(DetailsController());

  final args = Get.arguments as Map<String, dynamic>;
  late PlanModel model;

  @override
  void initState() {
    super.initState();
    model = args['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: h(context, 8)),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonImageView(
                      imagePath: Assets.imagesGreybackicon,
                      height: 48,
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  ),

                  StreamBuilder<DocumentSnapshot>(
                    stream: plansCollection.doc(model.id).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      final data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      final participants = List<String>.from(
                        data?['favIds'] ?? [],
                      );

                      final isUserInList = participants.contains(
                        auth.currentUser?.uid,
                      );

                      return InkWell(
                        onTap: () {
                          PlanController _ctrl = Get.put(PlanController());
                          if (isUserInList) {
                            _ctrl.removeFavouritePlan(
                              planId: model.id.toString(),
                            );
                          } else {
                            _ctrl.favouritePlan(planId: model.id.toString());
                          }
                        },
                        child: Container(
                          height: h(context, 48),
                          width: w(context, 48),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child:
                                isUserInList
                                    ? CommonImageView(
                                      imagePath: Assets.imagesHeart,
                                      height: 18,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    )
                                    : Icon(
                                      Icons.favorite_border,
                                      // color: kWhiteColor,
                                      size: 20,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: h(context, 8)),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: h(context, 340),
                        child: PageView.builder(
                          // controller: _controller.pageController,
                          itemCount: 1,
                          // onPageChanged: _controller.onPageChanged,
                          itemBuilder: (_, __) {
                            return Image.network(
                              model.planPhoto.toString(),
                              // Assets.imagesDetailsimage,
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                            );
                          },
                        ),
                      ),
                      // Obx(
                      //   () => Positioned(
                      //     bottom: h(context, 67),
                      //     left: 0,
                      //     right: 0,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: List.generate(
                      //         3,
                      //         (index) => Container(
                      //           margin: symmetric(
                      //             context,
                      //             horizontal: w(context, 1),
                      //           ),
                      //           height: h(context, 8),
                      //           width: w(context, 28),
                      //           decoration: BoxDecoration(
                      //             color:
                      //                 _controller.currentIndex.value == index
                      //                     ? kPrimaryColor
                      //                     : kPrimaryColor.withValues(
                      //                       alpha: 0.25,
                      //                     ),
                      //             borderRadius: BorderRadius.circular(
                      //               h(context, 100),
                      //             ),
                      //             border: Border.all(
                      //               color:
                      //                   _controller.currentIndex.value == index
                      //                       ? Colors.transparent
                      //                       : kPrimaryColor.withValues(
                      //                         alpha: 0.36,
                      //                       ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: symmetric(context, horizontal: 20),
                      height: h(context, 375),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(h(context, 25)),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: h(context, 22)),
                            CustomText(
                              text: model.title.toString(),
                              size: 24,
                              weight: FontWeight.w500,
                              color: kBlackColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              lineHeight: h(context, 1),
                              paddingBottom: 8,
                            ),
                            Row(
                              children: [
                                CommonImageView(
                                  imagePath: Assets.imagesLocationicon,
                                  height: 18,
                                  width: 18,
                                  fit: BoxFit.contain,
                                ),
                                Expanded(
                                  child: CustomText(
                                    text: model.location.toString(),
                                    size: 14,
                                    weight: FontWeight.w500,
                                    color: kBlackColor.withValues(alpha: 0.5),
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                    lineHeight: h(context, 1),
                                    paddingLeft: 4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h(context, 13)),
                            CustomText(
                              text: model.description.toString(),
                              size: 14,
                              weight: FontWeight.w500,
                              color: kBlackColor.withValues(alpha: 0.5),
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              lineHeight: h(context, 1.2),
                              paddingBottom: 20,
                            ),

                            // ------- Start Date & Time -------
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Start Date & Time",
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor.withValues(alpha: 0.5),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                  paddingBottom: 4,
                                ),
                                CustomText(
                                  text: dT.formatEventDateTime(
                                    // model.startDate!,
                                    dTime: model.startTime!,
                                    onlyDate: model.startDate!,
                                  ),
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                ),
                                SizedBox(height: 12),

                                CustomText(
                                  text: "End Date & Time",
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor.withValues(alpha: 0.5),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                  paddingBottom: 4,
                                ),
                                CustomText(
                                  text: dT.formatEventDateTime(
                                    // model.startDate!,
                                    dTime: model.endTime!,
                                    onlyDate: model.endDate!,
                                  ),
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                ),
                                SizedBox(height: 12),

                                CustomText(
                                  text: "Participants",
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kBlackColor.withValues(alpha: 0.5),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  lineHeight: h(context, 1),
                                  paddingBottom: 4,
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                  stream:
                                      plansCollection.doc(model.id).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }

                                    final data =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>?;
                                    final participants = List<String>.from(
                                      data?['participantsIds'] ?? [],
                                    );

                                    return CustomText(
                                      text:
                                          "${participants.length}/${model.maxMembers} members joined",
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: kBlackColor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      lineHeight: h(context, 1),
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     // Column(
                            //     //   crossAxisAlignment: CrossAxisAlignment.start,
                            //     //   children: [
                            //     //     CustomText(
                            //     //       text: "Date & Time",
                            //     //       size: 14,
                            //     //       weight: FontWeight.w500,
                            //     //       color: kBlackColor.withValues(alpha: 0.5),
                            //     //       fontFamily: AppFonts.HelveticaNowDisplay,
                            //     //       lineHeight: h(context, 1),
                            //     //       paddingBottom: 4,
                            //     //     ),
                            //     //     CustomText(
                            //     //       text: dT.formatEventDateTime(
                            //     //         // model.startDate!,
                            //     //         dTime: model.startTime!,
                            //     //         onlyDate: model.startDate!,
                            //     //       ),
                            //     //       size: 14,
                            //     //       weight: FontWeight.w500,
                            //     //       color: kBlackColor,
                            //     //       fontFamily: AppFonts.HelveticaNowDisplay,
                            //     //       lineHeight: h(context, 1),
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //     // SizedBox(
                            //     //   height: h(context, 36),
                            //     //   child: VerticalDivider(
                            //     //     color: Color(0xffE3E3E3),
                            //     //     width: w(context, 1),
                            //     //   ),
                            //     // ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         CustomText(
                            //           text: "Participants",
                            //           size: 14,
                            //           weight: FontWeight.w500,
                            //           color: kBlackColor.withValues(alpha: 0.5),
                            //           fontFamily: AppFonts.HelveticaNowDisplay,
                            //           lineHeight: h(context, 1),
                            //           paddingBottom: 4,
                            //         ),
                            //         StreamBuilder<DocumentSnapshot>(
                            //           stream:
                            //               plansCollection
                            //                   .doc(model.id)
                            //                   .snapshots(),
                            //           builder: (context, snapshot) {
                            //             if (!snapshot.hasData) {
                            //               return CircularProgressIndicator();
                            //             }

                            //             final data =
                            //                 snapshot.data!.data()
                            //                     as Map<String, dynamic>?;
                            //             final participants = List<String>.from(
                            //               data?['participantsIds'] ?? [],
                            //             );

                            //             return CustomText(
                            //               text:
                            //                   "${participants.length}/${model.maxMembers} members joined",
                            //               size: 14,
                            //               weight: FontWeight.w500,
                            //               color: kBlackColor,
                            //               fontFamily:
                            //                   AppFonts.HelveticaNowDisplay,
                            //               lineHeight: h(context, 1),
                            //             );
                            //           },
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: h(context, 50)),

                            // CHAT BUTTON
                            StreamBuilder<DocumentSnapshot>(
                              stream: chatCollection.doc(model.id).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }

                                final data =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>?;
                                final participants = List<String>.from(
                                  data?['participants'] ?? [],
                                );

                                final isParticipant = participants.contains(
                                  auth.currentUser!.uid,
                                );
                                log(auth.currentUser!.uid);

                                return isParticipant
                                    ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          () =>
                                              ChatScreen(chatHeadID: model.id!),
                                          binding: ChatBindings(),
                                          arguments: {'data': model},
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 12),
                                        height: h(context, 50),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          border: GradientBoxBorder(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff28E4D3),
                                                Color(0xffAFF888),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),

                                          borderRadius: BorderRadius.circular(
                                            h(context, 100),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonImageView(
                                              imagePath: Assets.imagesChaticon,
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.contain,
                                            ),

                                            // Checking if participantsIds is contains my ID then display group chat button
                                            CustomText(
                                              text: "Open group chat",
                                              size: 18,
                                              paddingLeft: 6,
                                              weight: FontWeight.w500,
                                              color: kSecondaryColor,
                                              fontFamily:
                                                  AppFonts.HelveticaNowDisplay,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    : SizedBox();
                              },
                            ),

                            // PLAN BUTTON
                            (model.planCreatorID == auth.currentUser?.uid)
                                ? DisableButton(text: "My Plan")
                                : (model.status == PlanStatus.completed.name)
                                ? DisableButton()
                                : StreamBuilder<DocumentSnapshot>(
                                  stream:
                                      plansCollection.doc(model.id).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }

                                    final data =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>?;
                                    final participants = List<String>.from(
                                      data?['participantsIds'] ?? [],
                                    );
                                    final isUserInList = participants.contains(
                                      auth.currentUser?.uid,
                                    );

                                    final int maxMembers =
                                        int.tryParse(model.maxMembers ?? '') ??
                                        0;

                                    final int currentMembers =
                                        model.participantsIds?.length ?? 0;

                                    final bool isPlanFull =
                                        currentMembers >= maxMembers;

                                    log(
                                      "User: ${maxMembers} -- ${model.participantsIds?.length}",
                                    );
                                    return (isPlanFull)
                                        ? CustomButton(
                                          onPressed: () {
                                            displayToast(
                                              msg:
                                                  "The plan is full. You cannot join.",
                                            );
                                          },

                                          text: "Plan Full",

                                          iscustomgradient: true,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff21E3D7),
                                              Color(0xffB5F985),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderradius: 100,
                                          size: 18,
                                          weight: FontWeight.w500,
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                          color: kBlackColor,
                                          height: 50,
                                          width: double.maxFinite,
                                        )
                                        : CustomButton(
                                          onPressed: () {
                                            log(
                                              "User is in list: $isUserInList",
                                            );
                                            PlanController _ctrl = Get.put(
                                              PlanController(),
                                            );
                                            if (isUserInList) {
                                              log("Leaving plan: ${model.id}");
                                              _ctrl.leavePlan(
                                                planId: model.id.toString(),
                                              );
                                            } else {
                                              log("joining plan: ${model.id}");
                                              _ctrl.joinPlan(
                                                planId: model.id.toString(),
                                              );
                                            }
                                          },

                                          text:
                                              isUserInList
                                                  ? "Leave Plan"
                                                  : "Join",
                                          iscustomgradient: true,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff21E3D7),
                                              Color(0xffB5F985),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderradius: 100,
                                          size: 18,
                                          weight: FontWeight.w500,
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                          color: kBlackColor,
                                          height: 50,
                                          width: double.maxFinite,
                                        );
                                  },
                                ),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
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
}
