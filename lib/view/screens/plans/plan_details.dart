import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/Home/details.dart';
import 'package:f2g/view/screens/my_plans/my_plans.dart';
import 'package:f2g/view/screens/plans/chat_screen.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

class PlansDetailScreen extends StatefulWidget {
  bool isStatusChange;
  PlansDetailScreen({super.key, this.isStatusChange = false});

  @override
  State<PlansDetailScreen> createState() => _PlansDetailScreenState();
}

class _PlansDetailScreenState extends State<PlansDetailScreen> {
  final args = Get.arguments as Map<String, dynamic>;
  late PlanModel data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = args['data'];
  }

  var _ctrl = Get.find<PlanController>();

  @override
  Widget build(BuildContext context) {
    // final List peoples = [
    //   people(context, Assets.imagesPersonimage1, "Will Martin"),
    //   people(context, Assets.imagesPersonimage2, "Mike Ross"),
    //   people(context, Assets.imagesPersonimage3, "James Vince"),
    //   people(context, Assets.imagesPersonimage4, "Obero Teer"),
    //   people(context, Assets.imagesPersonimage5, "Sean Caehill"),
    //   people(context, Assets.imagesPersonimage6, "Will Tanner"),
    //   people(context, Assets.imagesPersonimage7, "Mike Taylor"),
    // ];
    // final PlanModel data = args['data'];
    log("----------- >> data loaded: ${data.toMap()}");

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
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
                          text: "Plan Details",
                          size: 16,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: CommonImageView(
                      //     imagePath: Assets.images3dotscontainer,
                      //     height: 48,
                      //     width: 48,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: h(context, 20)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildActiveCompletedDetailsCard(data, context, () {
                            Get.to(
                              () => DetailsScreen(),
                              arguments: {'data': data},
                            );
                          }),
                          // ...peoples.map(
                          //   (e) => Padding(
                          //     padding: only(context, bottom: 8),
                          //     child: e,
                          //   ),
                          // ),
                          SizedBox(height: h(context, 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCompletedDetailsCard(
    PlanModel item,
    BuildContext context,
    VoidCallback onDetailPage,
  ) {
    return Container(
      margin: only(context, bottom: 10),
      padding: all(context, 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onDetailPage,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(h(context, 8)),
                  child: CommonImageView(
                    url: item.planPhoto,
                    fit: BoxFit.cover,
                    height: 46,
                    width: 48,
                  ),
                ),

                SizedBox(width: w(context, 9)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: item.title.toString(),
                        size: 16,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                      SizedBox(height: h(context, 4)),
                      Row(
                        children: [
                          CommonImageView(
                            imagePath: Assets.imagesLocationicon,
                            height: 16,
                            width: 16,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: w(context, 4)),
                          CustomText(
                            text: item.location.toString(),
                            size: 12,
                            weight: FontWeight.w500,
                            color: kBlackColor.withValues(alpha: 0.5),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h(context, 26),
                  padding: symmetric(context, horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        (item.status == PlanStatus.active.name)
                            ? const Color(0xff34A853).withValues(alpha: 0.08)
                            : kSecondaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(h(context, 100)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: h(context, 4),
                        width: w(context, 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (item.status == PlanStatus.active.name)
                                  ? Color(0xff34A853)
                                  : kSecondaryColor,
                        ),
                      ),
                      CustomText(
                        text: item.status!.capitalizeFirst.toString(),
                        size: 14,
                        paddingLeft: 6,
                        weight: FontWeight.w500,
                        color:
                            (item.status == PlanStatus.active.name)
                                ? Color(0xff34A853)
                                : kSecondaryColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h(context, 10)),
          Divider(
            color: Color(0xffE3E3E3),
            thickness: h(context, 1),
            height: h(context, 1),
          ),
          SizedBox(height: h(context, 10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: "Date & Time",
                  size: 12,
                  weight: FontWeight.w500,
                  color: kBlackColor.withValues(alpha: 0.5),
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
              CustomText(
                text: dT.formatEventDateTime(
                  dTime: item.startTime!,
                  onlyDate: item.startDate!,
                ),
                size: 14,
                weight: FontWeight.w500,
                color: kBlackColor,
                fontFamily: AppFonts.HelveticaNowDisplay,
              ),
            ],
          ),
          SizedBox(height: h(context, 10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: "Members Joined",
                  size: 12,
                  weight: FontWeight.w500,
                  color: kBlackColor.withValues(alpha: 0.5),
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: plansCollection.doc(item.id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  final participants = List<String>.from(
                    data?['participantsIds'] ?? [],
                  );

                  return CustomText(
                    text: "${participants.length}/${item.maxMembers}",
                    size: 14,
                    weight: FontWeight.w500,
                    color: kBlackColor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  );
                },
              ),
              // CustomText(
              //   text: "${item.participantsIds?.length}",
              //   size: 14,
              //   weight: FontWeight.w500,
              //   color: kBlackColor,
              //   fontFamily: AppFonts.HelveticaNowDisplay,
              // ),
            ],
          ),
          item.status == "Active"
              ? SizedBox(height: h(context, 10))
              : SizedBox.shrink(),
          item.status == "Active"
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      text: "Slots Left",
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackColor.withValues(alpha: 0.5),
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ),
                  CustomText(
                    text: "07",
                    size: 14,
                    weight: FontWeight.w500,
                    color: kBlackColor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                ],
              )
              : SizedBox.shrink(),

          SizedBox(height: h(context, 10)),

          StreamBuilder<DocumentSnapshot>(
            stream: chatCollection.doc(item.id).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final data = snapshot.data!.data() as Map<String, dynamic>?;
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
                        () => ChatScreen(chatHeadID: item.id!),
                        binding: ChatBindings(),
                        arguments: {'data': item},
                      );
                    },
                    child: Container(
                      height: h(context, 42),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [Color(0xff28E4D3), Color(0xffAFF888)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),

                        borderRadius: BorderRadius.circular(h(context, 8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            size: 14,
                            paddingLeft: 6,
                            weight: FontWeight.w500,
                            color: kSecondaryColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox();
            },
          ),

          (widget.isStatusChange)
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    paddingTop: 20,
                    paddingBottom: 10,
                    text: "Change Plan Status:",
                    color: kBlackColor,
                    size: 12,
                    weight: FontWeight.w600,
                  ),

                  Row(
                    children: List.generate(
                      2,
                      (index) => Expanded(
                        child: Obx(
                          () => StatusButton(
                            onTap: () async {
                              _ctrl.buttonStatusIndex.value = index;
                              if (index == 0) {
                                _ctrl.planStatusToggel(
                                  docID: item.id!,
                                  status: PlanStatus.active.name,
                                );
                              } else {
                                _ctrl.planStatusToggel(
                                  docID: item.id!,
                                  status: PlanStatus.completed.name,
                                );
                              }
                            },
                            text: (index == 0) ? "Active" : "Completed",
                            isStatusActive:
                                (_ctrl.buttonStatusIndex.value == index)
                                    ? true
                                    : false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget people(BuildContext context, String image, String name) {
    return Container(
      height: h(context, 46),
      padding: symmetric(context, horizontal: 10),
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 10)),
      ),
      child: Row(
        children: [
          CommonImageView(
            imagePath: image,
            height: 36,
            width: 36,
            fit: BoxFit.contain,
          ),
          SizedBox(width: w(context, 6)),
          CustomText(
            text: name,
            size: 16,
            weight: FontWeight.w500,
            color: kBlackColor,
            fontFamily: AppFonts.HelveticaNowDisplay,
          ),
        ],
      ),
    );
  }
}
