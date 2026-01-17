import 'dart:math';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/screens/persons_informations/single_person_info.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ParticipantsInformationScreen extends StatefulWidget {
  final List<String> participantsIds;
  final String image, title;
  const ParticipantsInformationScreen({
    super.key,
    required this.participantsIds,
    required this.image,
    required this.title,
  });

  @override
  State<ParticipantsInformationScreen> createState() =>
      _ParticipantsInformationScreenState();
}

class _ParticipantsInformationScreenState
    extends State<ParticipantsInformationScreen> {
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  _participantsStream() {
    final ids = widget.participantsIds
        .where((id) => id.trim().isNotEmpty)
        .toList(growable: false);

    if (ids.isEmpty) {
      return Stream.value(<QueryDocumentSnapshot<Map<String, dynamic>>>[]);
    }

    final batches = <List<String>>[];
    for (var i = 0; i < ids.length; i += 10) {
      batches.add(ids.sublist(i, min(i + 10, ids.length)));
    }

    final streams =
        batches
            .map(
              (batch) =>
                  FirebaseFirestore.instance
                      .collection('user')
                      .where(FieldPath.documentId, whereIn: batch)
                      .snapshots(),
            )
            .toList();

    if (streams.length == 1) {
      return streams.first.map((snap) => snap.docs);
    }

    return StreamZip(
      streams,
    ).map((snapshots) => snapshots.expand((snap) => snap.docs).toList());
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("-----------------------------");
    debugPrint("-----------------------------");
    debugPrint("Participants IDs: ${widget.participantsIds}");
    debugPrint("-----------------------------");
    debugPrint("-----------------------------");
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profilebg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyBackBtn(),
                SizedBox(height: h(context, 20)),
                Center(
                  child: Column(
                    children: [
                      CommonImageView(
                        url: widget.image,
                        height: 80,
                        width: 80,
                        radius: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: h(context, 12)),
                      CustomText(
                        text: widget.title,
                        size: 20,
                        lineHeight: h(context, 1),
                        paddingBottom: 4,
                        weight: FontWeight.w700,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                      CustomText(
                        text:
                            "${widget.participantsIds.length} members in this group",
                        size: 16,
                        lineHeight: h(context, 1),
                        paddingBottom: 3,
                        weight: FontWeight.w400,
                        color: kBlackColor.withValues(alpha: .5),
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h(context, 18)),
                CustomText(
                  text: "Members",
                  size: 16,
                  lineHeight: h(context, 1),
                  paddingBottom: 10,
                  weight: FontWeight.w500,
                  color: kBlackColor.withValues(alpha: .5),
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
                Expanded(
                  child: StreamBuilder<
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>
                  >(
                    stream: _participantsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kSecondaryColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: CustomText(
                            text: "Something went wrong. Please try again.",
                            size: 14,
                            weight: FontWeight.w500,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final participants = snapshot.data ?? [];

                      if (participants.isEmpty) {
                        return Center(
                          child: CustomText(
                            text: "No participants available yet",
                            size: 15,
                            weight: FontWeight.w500,
                            color: kBlackColor.withValues(alpha: 0.7),
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: participants.length,
                              separatorBuilder:
                                  (_, __) => SizedBox(height: h(context, 10)),
                              itemBuilder: (_, index) {
                                final user = participants[index].data();
                                final name =
                                    (user['fullName'] as String?)?.trim();
                                final profileImage =
                                    (user['profileImage'] as String?) ?? '';

                                return InkWell(
                                  borderRadius: BorderRadius.circular(
                                    h(context, 16),
                                  ),
                                  onTap: () {
                                    Get.to(
                                      () => SinglePersonInformationScreen(
                                        userId:
                                            participants[index].reference.id,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w(context, 14),
                                      vertical: h(context, 10),
                                    ),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(
                                        h(context, 16),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.03,
                                          ),
                                          offset: const Offset(0, 8),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            h(context, 100),
                                          ),
                                          child: CommonImageView(
                                            url: profileImage,
                                            imagePath:
                                                profileImage.isEmpty
                                                    ? Assets.imagesNoImageFound
                                                    : null,
                                            height: 42,
                                            width: 42,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: w(context, 12)),
                                        Expanded(
                                          child: CustomText(
                                            text:
                                                name?.isNotEmpty == true
                                                    ? name!
                                                    : "Member",
                                            size: 15,
                                            weight: FontWeight.w500,
                                            color: kBlackColor,
                                            fontFamily:
                                                AppFonts.HelveticaNowDisplay,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Color(0xff0097A7),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBackBtn extends StatelessWidget {
  final String? title;
  const MyBackBtn({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
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

        CustomText(
          text: title ?? "Group Profile",
          size: 16,
          weight: FontWeight.w500,
          color: kBlackColor,
          fontFamily: AppFonts.HelveticaNowDisplay,
          paddingLeft: 12,
        ),
      ],
    );
  }
}
