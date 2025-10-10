import 'dart:developer';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/plans/plan_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../../constants/app_fonts.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final _ctrl = Get.find<PlanController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrl.fetchFav();
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: h(context, 19)),
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
                        text: "Favourites",
                        size: 20,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 12)),
                  Expanded(
                    child: Obx(
                      () => Column(
                        children: [
                          _ctrl.isLoading.value
                              ? Expanded(child: Center(child: WaveLoading()))
                              : _ctrl.favourites.isEmpty
                              ? Expanded(
                                child: Center(
                                  child: CustomText(
                                    text: "No favourites plans found!",
                                    color: kBlackColor,
                                    size: 13,
                                  ),
                                ),
                              )
                              : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _ctrl.favourites.length,
                                itemBuilder: (context, index) {
                                  final item = _ctrl.favourites[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => PlansDetailScreen(),
                                        arguments: {'data': item},
                                      );
                                    },
                                    child: _buildFavouriteCard(item, context),
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Obx(
                  //     () =>
                  //         _controller.favouriteList.isEmpty
                  //             ? _buildEmptyWidget(context)
                  //             : ListView.builder(
                  //               padding: symmetric(context, vertical: 10),
                  //               itemCount: _controller.favouriteList.length,
                  //               itemBuilder: (_, index) {
                  //                 final item = _controller.favouriteList[index];
                  //                 return _buildFavouriteCard(item, context);
                  //               },
                  //             ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: CustomText(
        text: "No favourites yet",
        size: 20,
        weight: FontWeight.w500,
        color: kBlackColor,
        fontFamily: AppFonts.HelveticaNowDisplay,
      ),
    );
  }

  Widget _buildFavouriteCard(PlanModel item, BuildContext context) {
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
                      item.status == PlanStatus.active.name
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
                            item.status == PlanStatus.active.name
                                ? Color(0xff34A853)
                                : kSecondaryColor,
                      ),
                    ),
                    CustomText(
                      text: item.status.toString(),
                      size: 14,
                      paddingLeft: 6,
                      weight: FontWeight.w500,
                      color:
                          item.status == PlanStatus.active.name
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
          SizedBox(height: h(context, 10)),
          InkWell(
            onTap: () async {
              log("Removing from fav ${item.id}");
              await _ctrl.removeFavouritePlan(planId: item.id!);
              Get.close(1);
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
              child: Center(
                child: CustomText(
                  text: "Remove from Favourites",
                  size: 14,
                  weight: FontWeight.w500,
                  color: kSecondaryColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
