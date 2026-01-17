import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/view/screens/persons_informations/participants_information.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';

class SinglePersonInformationScreen extends StatefulWidget {
  final String userId;
  const SinglePersonInformationScreen({super.key, required this.userId});

  @override
  State<SinglePersonInformationScreen> createState() =>
      _SinglePersonInformationScreenState();
}

class _SinglePersonInformationScreenState
    extends State<SinglePersonInformationScreen> {
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
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: userCollection.doc(widget.userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: CustomText(
                      text: "Unable to load user right now.",
                      size: 14,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(
                    child: CustomText(
                      text: "User not found.",
                      size: 14,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  );
                }

                final data = snapshot.data!.data() ?? {};
                final name =
                    (data['fullName'] as String?)?.trim().isNotEmpty == true
                        ? data['fullName'] as String
                        : "Member";
                final email = (data['email'] as String?) ?? '';
                final location = (data['location'] as String?) ?? '';
                final profileImage = (data['profileImage'] as String?) ?? '';
                final bio = (data['bio'] as String?) ?? '';

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyBackBtn(),
                      SizedBox(height: h(context, 24)),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(h(context, 100)),
                          child: CommonImageView(
                            url: profileImage,
                            imagePath:
                                profileImage.isEmpty
                                    ? Assets.imagesNoImageFound
                                    : null,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: h(context, 14)),
                      CustomText(
                        text: name,
                        size: 20,
                        weight: FontWeight.w700,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                        paddingBottom: 6,
                      ),
                      if (email.isNotEmpty)
                        CustomText(
                          text: email,
                          size: 16,
                          weight: FontWeight.w400,
                          color: kBlackColor.withValues(alpha: .6),
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          paddingBottom: 10,
                        ),
                      if (location.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16),
                            SizedBox(width: w(context, 4)),
                            CustomText(
                              text: location,
                              size: 16,
                              weight: FontWeight.w500,
                              color: kBlackColor.withValues(alpha: .6),
                              fontFamily: AppFonts.HelveticaNowDisplay,
                            ),
                          ],
                        ),
                      if (bio.isNotEmpty) ...[
                        SizedBox(height: h(context, 18)),
                        Container(
                          width: double.infinity,
                          // padding: EdgeInsets.all(w(context, 14)),
                          // decoration: BoxDecoration(
                          //   color: kWhiteColor,
                          //   borderRadius: BorderRadius.circular(h(context, 12)),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.black.withValues(alpha: 0.03),
                          //       offset: const Offset(0, 8),
                          //       blurRadius: 16,
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "BIOGRAPHY",
                                size: 16,
                                weight: FontWeight.w400,
                                color: kBlackColor.withValues(alpha: .5),
                                fontFamily: AppFonts.HelveticaNowDisplay,
                                paddingBottom: 8,
                              ),
                              CustomText(
                                text: bio,
                                size: 14,
                                weight: FontWeight.w400,
                                color: kBlackColor,
                                fontFamily: AppFonts.HelveticaNowDisplay,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
