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

class PlansScreen extends StatefulWidget {
  String? categorieValue;
  PlansScreen({super.key, this.categorieValue});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  PlanController _ctrl = Get.find<PlanController>();

  @override
  void initState() {
    super.initState();
    if (widget.categorieValue != null) {
      _ctrl.fetchPlans(
        status: PlanStatus.active.name,
        planCategories: widget.categorieValue,
      );
    } else {
      _ctrl.fetchPlans(status: PlanStatus.active.name);
    }
  }

  //
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
                          onTap: () {
                            Get.back();
                          },
                          child: CommonImageView(
                            imagePath: Assets.imagesMenu,
                            height: 48,
                            width: 48,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: w(context, 15)),
                        CustomText(
                          text: "Plans",
                          size: 20,
                          weight: FontWeight.w500,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ],
                    ),
                    SizedBox(height: h(context, 20)),
                    Container(
                      padding: symmetric(context, horizontal: 3, vertical: 2),
                      height: h(context, 38),
                      width: w(context, double.maxFinite),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(h(context, 14)),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(h(context, 12)),
                          color: kSecondaryColor,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(
                          fontSize: f(context, 14),
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: f(context, 14),
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                        dividerHeight: h(context, 0),
                        labelColor: kWhiteColor,
                        unselectedLabelColor: ktextcolor,
                        indicatorColor: Colors.transparent,
                        onTap: (value) async {
                          log("$value");

                          if (value == 0) {
                            if (widget.categorieValue != null) {
                              _ctrl.fetchPlans(
                                status: PlanStatus.active.name,
                                planCategories: widget.categorieValue,
                              );
                            } else {
                              _ctrl.fetchPlans(status: PlanStatus.active.name);
                            }
                          } else {
                            if (widget.categorieValue != null) {
                              _ctrl.fetchPlans(
                                status: PlanStatus.completed.name,
                                planCategories: widget.categorieValue,
                              );
                            } else {
                              _ctrl.fetchPlans(
                                status: PlanStatus.completed.name,
                              );
                            }
                          }
                        },
                        tabs: [Tab(text: 'Active'), Tab(text: 'Expired')],
                      ),
                    ),
                    SizedBox(height: h(context, 20)),

                    Obx(
                      () => Expanded(
                        child: TabBarView(
                          children: [
                            // ACTIVE PLANS TAB
                            _ctrl.isLoading.value
                                ? Center(child: WaveLoading())
                                : _ctrl.plans.isEmpty
                                ? Center(
                                  child: CustomText(
                                    text: "No Plans Found!",
                                    color: kBlackColor,
                                    size: 13,
                                  ),
                                )
                                : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _ctrl.plans.length,
                                  itemBuilder: (context, index) {
                                    final item = _ctrl.plans[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => PlansDetailScreen(),
                                          arguments: {'data': item},
                                        );
                                      },
                                      child: _buildActiveCompletedCard(
                                        item,
                                        context,
                                      ),
                                    );
                                  },
                                ),

                            // EXPIRED PLANS TAB
                            _ctrl.isLoading.value
                                ? Center(child: WaveLoading())
                                : _ctrl.plans.isEmpty
                                ? Center(
                                  child: CustomText(
                                    text: "No Plans Found!",
                                    color: kBlackColor,
                                    size: 13,
                                  ),
                                )
                                : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _ctrl.plans.length,
                                  itemBuilder: (context, index) {
                                    final item = _ctrl.plans[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => PlansDetailScreen(),
                                          arguments: {'data': item},
                                        );
                                      },
                                      child: _buildActiveCompletedCard(
                                        item,
                                        context,
                                      ),
                                    );
                                  },
                                ),
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
          SizedBox(height: h(context, 10)),
          Divider(
            color: Color(0xffE3E3E3),
            thickness: h(context, 1),
            height: h(context, 1),
          ),
          SizedBox(height: h(context, 10)),
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
                      text: dT.formatEventDateTime(item.startDate!),
                      size: 14,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ],
                ),
              ),

              StreamBuilder<DocumentSnapshot>(
                stream: plansCollection.doc(item.id).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>?;

                  // List of participant IDs
                  final participantIds = List<String>.from(
                    data?['participantsIds'] ?? [],
                  );

                  // If no participants, show nothing
                  if (participantIds.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  // Get only first 3 participant IDs
                  final limitedIds = participantIds.take(3).toList();

                  return FutureBuilder<List<DocumentSnapshot>>(
                    future: Future.wait(
                      limitedIds.map(
                        (uid) =>
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(uid)
                                .get(),
                      ),
                    ),
                    builder: (context, userSnapshots) {
                      if (!userSnapshots.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final userDocs =
                          userSnapshots
                              .data!; // List<DocumentSnapshot<Map<String, dynamic>>?>

                      final validUsers =
                          userDocs
                              .where(
                                (doc) =>
                                    (doc as DocumentSnapshot).exists &&
                                    doc.data() != null,
                              )
                              .map((doc) => UserModel.fromMap(doc))
                              .toList();

                      if (validUsers.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      log("Valid Users: ${validUsers.length}");

                      return SizedBox();
                    },
                  );
                },
              ),

              // Stack(
              //   clipBehavior: Clip.none,
              //   children: List.generate(
              //     item.avatars.length,
              //     (i) => Padding(
              //       padding: only(context, left: w(context, i * 18.0)),
              //       child: CommonImageView(
              //         imagePath: item.avatars[i],
              //         height: 28,
              //         width: 28,
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
