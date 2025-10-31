import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:f2g/view/screens/plans/plan_details.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPlansScreen extends StatefulWidget {
  const MyPlansScreen({super.key});

  @override
  State<MyPlansScreen> createState() => _MyPlansScreenState();
}

class _MyPlansScreenState extends State<MyPlansScreen> {
  final PlanController _ctrl = Get.find<PlanController>();

  @override
  void initState() {
    super.initState();

    // Delay fetch to avoid reactive rebuild during first frame
    Future.microtask(() => _ctrl.fetchMyPlan());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                          onTap: () => Get.back(),
                          child: CommonImageView(
                            imagePath: Assets.imagesMenu,
                            height: 48,
                            width: 48,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: w(context, 15)),
                        CustomText(
                          text: "My Plans",
                          size: 20,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ],
                    ),
                    SizedBox(height: h(context, 20)),

                    /// ✅ Only one Obx wrapper
                    Expanded(
                      child: Obx(() {
                        if (_ctrl.isLoading.value) {
                          return Center(child: WaveLoading());
                        }

                        if (_ctrl.myPlans.isEmpty) {
                          return Center(
                            child: CustomText(
                              text: "No Plans Found!",
                              color: kBlackColor,
                              size: 13,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: _ctrl.myPlans.length,
                          itemBuilder: (context, index) {
                            final item = _ctrl.myPlans[index];
                            return InkWell(
                              onTap: () {
                                // ✅ Navigation safely deferred to next frame
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  Get.to(
                                    () =>
                                        PlansDetailScreen(isStatusChange: true),
                                    arguments: {'data': item},
                                  );
                                });
                              },
                              child: _buildActiveCompletedCard(item, context),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCompletedCard(PlanModel item, BuildContext context) {
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
          /// --- Header ---
          Row(
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
                      text: item.title ?? '',
                      size: 16,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                    SizedBox(height: h(context, 4)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonImageView(
                          imagePath: Assets.imagesLocationicon,
                          height: 16,
                          width: 16,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: w(context, 4)),
                        Expanded(
                          child: CustomText(
                            text: item.location ?? '',
                            size: 14,
                            weight: FontWeight.w500,
                            color: kBlackColor.withValues(alpha: 0.5),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
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
                                ? const Color(0xff34A853)
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
                              ? const Color(0xff34A853)
                              : kSecondaryColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h(context, 10)),
          Divider(
            color: const Color(0xffE3E3E3),
            thickness: h(context, 1),
            height: h(context, 1),
          ),
          SizedBox(height: h(context, 10)),

          /// --- Date and Participants ---
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Date & Time",
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackColor.withValues(alpha: 0.5),
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                    SizedBox(height: h(context, 2)),
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
              ),

              /// --- Live Participant Avatars ---
              StreamBuilder<DocumentSnapshot>(
                stream: plansCollection.doc(item.id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>?;

                  final participantIds = List<String>.from(
                    data?['participantsIds'] ?? [],
                  );

                  if (participantIds.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final limitedIds = participantIds.take(3).toList();

                  return FutureBuilder<List<DocumentSnapshot>>(
                    future: Future.wait(
                      limitedIds.map((uid) => userCollection.doc(uid).get()),
                    ),
                    builder: (context, userSnapshots) {
                      if (!userSnapshots.hasData) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }

                      final userDocs = userSnapshots.data!;
                      final validUsers =
                          userDocs
                              .where((doc) => doc.exists && doc.data() != null)
                              .map((doc) => UserModel.fromMap(doc))
                              .toList();

                      if (validUsers.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      log("Valid Users: ${validUsers.length}");

                      return Stack(
                        clipBehavior: Clip.none,
                        children: List.generate(validUsers.length, (i) {
                          return Padding(
                            padding: only(context, left: w(context, i * 18.0)),
                            child: CommonImageView(
                              radius: 100,
                              url: validUsers[i].profileImage,
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  bool isStatusActive;
  String? text;
  VoidCallback? onTap;
  StatusButton({super.key, this.isStatusActive = false, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 33,
        decoration: BoxDecoration(
          color:
              (isStatusActive)
                  ? kSecondaryColor
                  : kSecondaryColor.withValues(alpha: 0.1),
          border: Border.all(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              paddingRight: 3,
              text: "$text",
              color: (isStatusActive) ? kWhiteColor : kBlackColor,
              size: 12,
            ),
            (isStatusActive)
                ? Icon(Icons.done, size: 14, color: kWhiteColor)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
