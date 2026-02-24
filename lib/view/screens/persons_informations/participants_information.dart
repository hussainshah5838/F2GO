// import 'dart:math';
// import 'package:async/async.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:f2g/constants/app_colors.dart';
// import 'package:f2g/constants/app_fonts.dart';
// import 'package:f2g/constants/app_images.dart';
// import 'package:f2g/constants/app_styling.dart';
// import 'package:f2g/view/screens/persons_informations/single_person_info.dart';
// import 'package:f2g/view/widget/Custom_text_widget.dart';
// import 'package:f2g/view/widget/common_image_view_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';

// class ParticipantsInformationScreen extends StatefulWidget {
//   final List<String> participantsIds;
//   final String planCreatorId; // Add this parameter
//   final String image, title;
//   final String docID;
//   const ParticipantsInformationScreen({
//     super.key,
//     required this.participantsIds,
//     required this.planCreatorId, // Add this
//     required this.image,
//     required this.title,
//     required this.docID,
//   });

//   @override
//   State<ParticipantsInformationScreen> createState() =>
//       _ParticipantsInformationScreenState();
// }

// class _ParticipantsInformationScreenState
//     extends State<ParticipantsInformationScreen> {
//   // Stream for creator
//   Stream<DocumentSnapshot<Map<String, dynamic>>> _creatorStream() {
//     return FirebaseFirestore.instance
//         .collection('user')
//         .doc(widget.planCreatorId)
//         .snapshots();
//   }

//   // Stream for participants (excluding creator)
//   Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
//   _participantsStream() {
//     // Filter out the creator from participants list
//     final ids = widget.participantsIds
//         .where((id) => id.trim().isNotEmpty && id != widget.planCreatorId)
//         .toList(growable: false);

//     if (ids.isEmpty) {
//       return Stream.value(<QueryDocumentSnapshot<Map<String, dynamic>>>[]);
//     }

//     final batches = <List<String>>[];
//     for (var i = 0; i < ids.length; i += 10) {
//       batches.add(ids.sublist(i, min(i + 10, ids.length)));
//     }

//     final streams =
//         batches
//             .map(
//               (batch) =>
//                   FirebaseFirestore.instance
//                       .collection('user')
//                       .where(FieldPath.documentId, whereIn: batch)
//                       .snapshots(),
//             )
//             .toList();

//     if (streams.length == 1) {
//       return streams.first.map((snap) => snap.docs);
//     }

//     return StreamZip(
//       streams,
//     ).map((snapshots) => snapshots.expand((snap) => snap.docs).toList());
//   }

//   // Widget to build user card
//   Widget _buildUserCard(
//     BuildContext context, {
//     required String userId,
//     required String name,
//     required String profileImage,
//     bool isCreator = false,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(h(context, 16)),
//       onTap: () {
//         Get.to(() => SinglePersonInformationScreen(userId: userId));
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: w(context, 14),
//           vertical: h(context, 10),
//         ),
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           borderRadius: BorderRadius.circular(h(context, 16)),
//           border:
//               isCreator ? Border.all(color: kSecondaryColor, width: 2) : null,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.03),
//               offset: const Offset(0, 8),
//               blurRadius: 16,
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(h(context, 100)),
//                   child: CommonImageView(
//                     url: profileImage,
//                     imagePath:
//                         profileImage.isEmpty ? Assets.imagesNoImageFound : null,
//                     height: 42,
//                     width: 42,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 if (isCreator)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: kSecondaryColor,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: kWhiteColor, width: 1.5),
//                       ),
//                       child: Icon(Icons.star, size: 12, color: kWhiteColor),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(width: w(context, 12)),
//             Expanded(
//               child: CustomText(
//                 text: name.isNotEmpty ? name : "Member",
//                 size: 15,
//                 weight: FontWeight.w500,
//                 color: kBlackColor,
//                 fontFamily: AppFonts.HelveticaNowDisplay,
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               size: 16,
//               color: Color(0xff0097A7),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate members count (excluding creator)
//     final membersCount =
//         widget.participantsIds
//             .where((id) => id.trim().isNotEmpty && id != widget.planCreatorId)
//             .length;

//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/images/profilebg.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MyBackBtn(),
//                 SizedBox(height: h(context, 20)),
//                 Center(
//                   child: Column(
//                     children: [
//                       CommonImageView(
//                         url: widget.image,
//                         height: 80,
//                         width: 80,
//                         radius: 100,
//                         fit: BoxFit.cover,
//                       ),
//                       SizedBox(height: h(context, 12)),
//                       CustomText(
//                         text: widget.title,
//                         size: 20,
//                         lineHeight: h(context, 1),
//                         paddingBottom: 4,
//                         weight: FontWeight.w700,
//                         color: kBlackColor,
//                         fontFamily: AppFonts.HelveticaNowDisplay,
//                       ),
//                       CustomText(
//                         text: "$membersCount members in this group",
//                         size: 16,
//                         lineHeight: h(context, 1),
//                         paddingBottom: 3,
//                         weight: FontWeight.w400,
//                         color: kBlackColor.withValues(alpha: .5),
//                         fontFamily: AppFonts.HelveticaNowDisplay,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: h(context, 18)),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Plan Creator Section
//                         CustomText(
//                           text: "Plan Creator",
//                           size: 16,
//                           lineHeight: h(context, 1),
//                           paddingBottom: 10,
//                           weight: FontWeight.w500,
//                           color: kBlackColor.withValues(alpha: .5),
//                           fontFamily: AppFonts.HelveticaNowDisplay,
//                         ),
//                         StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                           stream: _creatorStream(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20),
//                                   child: CircularProgressIndicator(
//                                     color: kSecondaryColor,
//                                   ),
//                                 ),
//                               );
//                             }

//                             if (snapshot.hasError || !snapshot.hasData) {
//                               return SizedBox.shrink();
//                             }

//                             final creator = snapshot.data!.data();
//                             if (creator == null) return SizedBox.shrink();

//                             final name =
//                                 (creator['fullName'] as String?)?.trim() ?? '';
//                             final profileImage =
//                                 (creator['profileImage'] as String?) ?? '';

//                             return _buildUserCard(
//                               context,
//                               userId: widget.planCreatorId,
//                               name: name,
//                               profileImage: profileImage,
//                               isCreator: true,
//                             );
//                           },
//                         ),

//                         SizedBox(height: h(context, 20)),

//                         // Members Section
//                         CustomText(
//                           text: "Members",
//                           size: 16,
//                           lineHeight: h(context, 1),
//                           paddingBottom: 10,
//                           weight: FontWeight.w500,
//                           color: kBlackColor.withValues(alpha: .5),
//                           fontFamily: AppFonts.HelveticaNowDisplay,
//                         ),
//                         StreamBuilder<
//                           List<QueryDocumentSnapshot<Map<String, dynamic>>>
//                         >(
//                           stream: _participantsStream(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20),
//                                   child: CircularProgressIndicator(
//                                     color: kSecondaryColor,
//                                   ),
//                                 ),
//                               );
//                             }

//                             if (snapshot.hasError) {
//                               return Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20),
//                                   child: CustomText(
//                                     text:
//                                         "Something went wrong. Please try again.",
//                                     size: 14,
//                                     weight: FontWeight.w500,
//                                     color: kBlackColor,
//                                     fontFamily: AppFonts.HelveticaNowDisplay,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               );
//                             }

//                             final participants = snapshot.data ?? [];

//                             if (participants.isEmpty) {
//                               return Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(20),
//                                   child: CustomText(
//                                     text: "No members yet",
//                                     size: 15,
//                                     weight: FontWeight.w500,
//                                     color: kBlackColor.withValues(alpha: 0.7),
//                                     fontFamily: AppFonts.HelveticaNowDisplay,
//                                   ),
//                                 ),
//                               );
//                             }

//                             return ListView.separated(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: participants.length,
//                               separatorBuilder:
//                                   (_, __) => SizedBox(height: h(context, 10)),
//                               itemBuilder: (_, index) {
//                                 final user = participants[index].data();
//                                 final name =
//                                     (user['fullName'] as String?)?.trim() ?? '';
//                                 final profileImage =
//                                     (user['profileImage'] as String?) ?? '';

//                                 return _buildUserCard(
//                                   context,
//                                   userId: participants[index].reference.id,
//                                   name: name,
//                                   profileImage: profileImage,
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyBackBtn extends StatelessWidget {
//   final String? title;
//   const MyBackBtn({super.key, this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: CommonImageView(
//             imagePath: Assets.imagesBackicon,
//             height: 48,
//             width: 48,
//             fit: BoxFit.contain,
//           ),
//         ),
//         CustomText(
//           text: title ?? "Group Profile",
//           size: 16,
//           weight: FontWeight.w500,
//           color: kBlackColor,
//           fontFamily: AppFonts.HelveticaNowDisplay,
//           paddingLeft: 12,
//         ),
//       ],
//     );
//   }
// }
import 'dart:developer' as developer;
import 'dart:math';
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
  final String docID;
  final String image, title;

  const ParticipantsInformationScreen({
    super.key,
    required this.docID,
    required this.image,
    required this.title,
  });

  @override
  State<ParticipantsInformationScreen> createState() =>
      _ParticipantsInformationScreenState();
}

class _ParticipantsInformationScreenState
    extends State<ParticipantsInformationScreen> {
  // Stream for the plan document
  Stream<DocumentSnapshot<Map<String, dynamic>>> _planStream() {
    return FirebaseFirestore.instance
        .collection('plans')
        .doc(widget.docID)
        .snapshots();
  }

  // Widget to build user card with direct fetch
  Widget _buildUserCardWithFetch(
    BuildContext context, {
    required String userId,
    bool isCreator = false,
  }) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.collection('user').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: w(context, 14),
              vertical: h(context, 10),
            ),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(h(context, 16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 42,
                  width: 42,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: kSecondaryColor,
                  ),
                ),
                SizedBox(width: w(context, 12)),
                Expanded(
                  child: CustomText(
                    text: "Loading...",
                    size: 15,
                    weight: FontWeight.w500,
                    color: kBlackColor.withValues(alpha: 0.5),
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          developer.log('Error loading user $userId: ${snapshot.error}');
          return SizedBox.shrink();
        }

        if (!snapshot.hasData || snapshot.data?.data() == null) {
          developer.log('No data for user $userId');
          return SizedBox.shrink();
        }

        final userData = snapshot.data!.data()!;
        developer.log('User $userId data: $userData');

        final name = (userData['fullName'] as String?)?.trim() ?? '';
        final profileImage = (userData['profileImage'] as String?) ?? '';

        return InkWell(
          borderRadius: BorderRadius.circular(h(context, 16)),
          onTap: () {
            Get.to(() => SinglePersonInformationScreen(userId: userId));
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: w(context, 14),
              vertical: h(context, 10),
            ),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(h(context, 16)),
              border:
                  isCreator
                      ? Border.all(color: kSecondaryColor, width: 2)
                      : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(h(context, 100)),
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
                    if (isCreator)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhiteColor, width: 1.5),
                          ),
                          child: Icon(Icons.star, size: 12, color: kWhiteColor),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: w(context, 12)),
                Expanded(
                  child: CustomText(
                    text: name.isNotEmpty ? name : "Member",
                    size: 15,
                    weight: FontWeight.w500,
                    color: kBlackColor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
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
    );
  }

  @override
  Widget build(BuildContext context) {
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

                // Main StreamBuilder for the plan document
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _planStream(),
                  builder: (context, planSnapshot) {
                    if (planSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kSecondaryColor,
                          ),
                        ),
                      );
                    }

                    if (planSnapshot.hasError || !planSnapshot.hasData) {
                      developer.log(
                        'Error loading plan: ${planSnapshot.error}',
                      );
                      return Expanded(
                        child: Center(
                          child: CustomText(
                            text: "Error loading plan data",
                            size: 14,
                            weight: FontWeight.w500,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ),
                      );
                    }

                    final planData = planSnapshot.data!.data();
                    if (planData == null) {
                      return Expanded(
                        child: Center(
                          child: CustomText(
                            text: "Plan not found",
                            size: 14,
                            weight: FontWeight.w500,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ),
                      );
                    }

                    developer.log('Plan data: $planData');

                    // Extract data from plan document
                    final participantsIds = List<String>.from(
                      planData['participantsIds'] ?? [],
                    );
                    final planCreatorId =
                        (planData['planCreatorID'] ?? '') as String;

                    developer.log('participantsIds: $participantsIds');
                    developer.log('planCreatorID: $planCreatorId');

                    // Filter members (excluding creator)
                    final memberIds =
                        participantsIds
                            .where(
                              (id) =>
                                  id.trim().isNotEmpty &&
                                  (planCreatorId.isEmpty ||
                                      id != planCreatorId),
                            )
                            .toList();

                    developer.log('memberIds (filtered): $memberIds');

                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                CommonImageView(
                                  url: widget.image,
                                  height: 80,
                                  width: 90,
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
                                      "${memberIds.length} members in this group",
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

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Plan Creator Section
                                  if (planCreatorId.isNotEmpty) ...[
                                    CustomText(
                                      text: "Plan Creator",
                                      size: 16,
                                      lineHeight: h(context, 1),
                                      paddingBottom: 10,
                                      weight: FontWeight.w500,
                                      color: kBlackColor.withValues(alpha: .5),
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                    ),
                                    _buildUserCardWithFetch(
                                      context,
                                      userId: planCreatorId,
                                      isCreator: true,
                                    ),
                                    SizedBox(height: h(context, 20)),
                                  ],

                                  // Members Section
                                  CustomText(
                                    text: "Members",
                                    size: 16,
                                    lineHeight: h(context, 1),
                                    paddingBottom: 10,
                                    weight: FontWeight.w500,
                                    color: kBlackColor.withValues(alpha: .5),
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                  ),

                                  if (memberIds.isEmpty)
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: CustomText(
                                          text: "No members yet",
                                          size: 15,
                                          weight: FontWeight.w500,
                                          color: kBlackColor.withValues(
                                            alpha: 0.7,
                                          ),
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                        ),
                                      ),
                                    )
                                  else
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: memberIds.length,
                                      separatorBuilder:
                                          (_, __) =>
                                              SizedBox(height: h(context, 10)),
                                      itemBuilder: (_, index) {
                                        final userId = memberIds[index];
                                        developer.log(
                                          'Building card for user: $userId',
                                        );
                                        return _buildUserCardWithFetch(
                                          context,
                                          userId: userId,
                                          isCreator: false,
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
