import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/screens/subscriptions/manage_subscriptions.dart';
import 'package:f2g/view/widget/Common_image_view_widget.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:f2g/view/widget/custom_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SubscriptionPlan { freeTrial, premium }

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.freeTrial;

  void _openPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => PaymentSelectionSheet(
            onSelectPayment: (method) {
              Navigator.pop(ctx);
              if (method == PaymentMethod.applePay) {
                _openApplePaySheet();
              } else {
                _openCardSheet();
              }
            },
          ),
    );
  }

  void _openApplePaySheet() {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   // builder: (_) => const ApplePaySheet(),
    // );
  }

  void _openCardSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CardInformationSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesProfilebg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h(context, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 10)),
                  CommonImageView(
                    width: 50,
                    height: 50,
                    imagePath: Assets.imagesLimitedPlan,
                  ),
                  SizedBox(height: h(context, 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Free Plan",
                              size: 22,
                              weight: FontWeight.w700,
                              color: kBlackColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              paddingBottom: 6,
                            ),
                            CustomText(
                              text:
                                  "Enjoy our amazing and affordable subscription plans.",
                              size: 14,
                              weight: FontWeight.w500,
                              color: ktextcolor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 20)),
                  _buildFeatureRow(context, "Limit of 2 plans per week"),
                  SizedBox(height: h(context, 10)),
                  _buildFeatureRow(
                    context,
                    "Filters: Distance + Category only",
                  ),
                  SizedBox(height: h(context, 10)),
                  _buildFeatureRow(
                    context,
                    "Notifications after reaching the weekly limit recommending upgrade.",
                  ),
                  const Spacer(),
                  _PlanOptionCard(
                    title: "FREE 1 MONTH PREMIUM TRIAL",
                    subtitle: "Start Free Trial",
                    isSelected: _selectedPlan == SubscriptionPlan.freeTrial,
                    onTap: () {
                      setState(() {
                        _selectedPlan = SubscriptionPlan.freeTrial;
                      });
                    },
                  ),
                  SizedBox(height: h(context, 12)),
                  _PlanOptionCard(
                    title: "PREMIUM PACKAGE",
                    subtitle: "\$99.99 /monthly",
                    isSelected: _selectedPlan == SubscriptionPlan.premium,
                    trailing: const Icon(
                      Icons.star_rounded,
                      color: Color(0xffFFB800),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedPlan = SubscriptionPlan.premium;
                      });
                    },
                  ),
                  SizedBox(height: h(context, 27)),
                  CustomButton(
                    onPressed: _openPaymentSheet,
                    text: "Continue",
                    borderradius: 100,
                    size: 18,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kBlackColor,
                    height: 50,
                    width: double.maxFinite,
                  ),
                  SizedBox(height: h(context, 17)),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          fontSize: f(context, 12),
                          color: ktextcolor,
                          fontWeight: FontWeight.w500,
                        ),
                        children: const [
                          TextSpan(text: "By signing in you agree to "),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(color: kSecondaryColor),
                          ),
                          TextSpan(text: " and our "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: kSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h(context, 15)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 16, color: kSecondaryColor),
        SizedBox(width: w(context, 10)),
        Expanded(
          child: CustomText(
            text: text,
            size: 14,
            weight: FontWeight.w500,
            color: kBlackColor,
            fontFamily: AppFonts.HelveticaNowDisplay,
          ),
        ),
      ],
    );
  }
}

class _PlanOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget? trailing;

  const _PlanOptionCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isSelected,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 80,
        padding: all(context, 12),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(h(context, 16)),

          boxShadow: [
            BoxShadow(
              color: kBlackColor.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],

          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [Color(0xff21E3D7), Color(0xffB5F985)],
                  )
                  : null,
        ),
        child: Column(
          children: [
            CustomText(
              text: title,
              size: 12,
              weight: FontWeight.w700,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: 5),
            SizedBox(height: h(context, 6)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (isSelected) ? kWhiteColor : Color(0xffF4F6FA),
              ),
              child: Row(
                children: [
                  Container(
                    height: h(context, 20),
                    width: h(context, 20),
                    decoration: BoxDecoration(
                      color: (isSelected) ? null : kWhiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            (isSelected)
                                ? kBlackColor.withValues(alpha: 0.1)
                                : kWhiteColor,
                        width: 4,
                      ),
                    ),
                    child:
                        isSelected
                            ? Container(
                              height: h(context, 10),
                              width: h(context, 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kSecondaryColor,
                              ),
                            )
                            : null,
                  ),
                  SizedBox(width: w(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: subtitle,
                          size: 16,
                          weight: FontWeight.w600,
                          color: kBlackColor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum PaymentMethod { card, applePay, googlePay, gPay, americanExpress }

class PaymentSelectionSheet extends StatefulWidget {
  final ValueChanged<PaymentMethod> onSelectPayment;
  const PaymentSelectionSheet({super.key, required this.onSelectPayment});

  @override
  State<PaymentSelectionSheet> createState() => _PaymentSelectionSheetState();
}

class _PaymentSelectionSheetState extends State<PaymentSelectionSheet> {
  PaymentMethod _selectedMethod = PaymentMethod.card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        w(context, 20),
        h(context, 14),
        w(context, 20),
        h(context, 20),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: h(context, 4),
              width: w(context, 40),
              margin: EdgeInsets.only(bottom: h(context, 12)),
              decoration: BoxDecoration(
                color: kBlackColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            // Back Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 20),
                      SizedBox(width: w(context, 6)),
                      CustomText(
                        text: "Back",
                        size: 14,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 10)),

            // Title
            CustomText(
              text: "Select Payment",
              size: 20,
              weight: FontWeight.w700,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: h(context, 4)),
            CustomText(
              text: "Please select the preferred payment method.",
              size: 14,
              weight: FontWeight.w500,
              color: ktextcolor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            SizedBox(height: h(context, 18)),
            Wrap(
              spacing: w(context, 10),
              runSpacing: h(context, 10),
              children: [
                _PaymentTile(
                  label: "Debit/Credit Card",
                  icon: Assets.imagesCardType,
                  isSelected: _selectedMethod == PaymentMethod.card,
                  onTap:
                      () => setState(() {
                        _selectedMethod = PaymentMethod.card;
                      }),
                ),
                _PaymentTile(
                  label: "Apple Pay",
                  icon: Assets.imagesApplePay,
                  isSelected: _selectedMethod == PaymentMethod.applePay,
                  onTap:
                      () => setState(() {
                        _selectedMethod = PaymentMethod.applePay;
                      }),
                ),
                _PaymentTile(
                  label: "Google Pay",
                  icon: Assets.imagesGooglelogo,
                  isSelected: _selectedMethod == PaymentMethod.googlePay,
                  onTap:
                      () => setState(() {
                        _selectedMethod = PaymentMethod.googlePay;
                      }),
                ),
                _PaymentTile(
                  label: "American Express",
                  icon: Assets.imagesAmericanExpressIcon,
                  isSelected: _selectedMethod == PaymentMethod.americanExpress,
                  onTap:
                      () => setState(() {
                        _selectedMethod = PaymentMethod.americanExpress;
                      }),
                ),
              ],
            ),
            SizedBox(height: h(context, 18)),
            CustomButton(
              onPressed: () => widget.onSelectPayment(_selectedMethod),
              text: "Continue",
              borderradius: 100,
              size: 18,
              weight: FontWeight.w500,
              fontFamily: AppFonts.HelveticaNowDisplay,
              color: kBlackColor,
              height: 50,
              width: double.maxFinite,
            ),
            SizedBox(height: h(context, 4)),
          ],
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: (MediaQuery.of(context).size.width - w(context, 60)) / 2,
            padding: all(context, 12),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(h(context, 12)),
              border: Border.all(
                color:
                    isSelected
                        ? kSecondaryColor
                        : kWhiteColor.withValues(alpha: 0.05),
                width: 1.4,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment:
                      (isSelected)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                  children: [
                    CommonImageView(
                      imagePath: icon,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: kSecondaryColor,
                        size: 18,
                      ),
                  ],
                ),
                // Icon(icon, color: kBlackColor),
                SizedBox(width: w(context, 10)),
                CustomText(
                  text: label,
                  size: 14,
                  weight: FontWeight.w600,
                  color: kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ApplePaySheet extends StatelessWidget {
//   const ApplePaySheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: kWhiteColor,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       padding: EdgeInsets.fromLTRB(
//         w(context, 20),
//         h(context, 14),
//         w(context, 20),
//         h(context, 20),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: h(context, 4),
//               width: w(context, 40),
//               margin: EdgeInsets.only(bottom: h(context, 12)),
//               decoration: BoxDecoration(
//                 color: kBlackColor.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(100),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.arrow_back_ios_new, size: 16),
//                       SizedBox(width: w(context, 6)),
//                       CustomText(
//                         text: "Back",
//                         size: 14,
//                         weight: FontWeight.w500,
//                         color: kBlackColor,
//                         fontFamily: AppFonts.HelveticaNowDisplay,
//                       ),
//                     ],
//                   ),
//                 ),
//                 CustomText(
//                   text: "Apple Pay",
//                   size: 16,
//                   weight: FontWeight.w700,
//                   color: kBlackColor,
//                   fontFamily: AppFonts.HelveticaNowDisplay,
//                 ),
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.close, size: 22),
//                 ),
//               ],
//             ),
//             SizedBox(height: h(context, 12)),
//             CustomText(
//               text: "Double Click to Pay",
//               size: 14,
//               weight: FontWeight.w600,
//               color: kBlackColor.withValues(alpha: 0.7),
//               fontFamily: AppFonts.HelveticaNowDisplay,
//               paddingBottom: 12,
//             ),
//             _ApplePayRow(
//               title: "Apple Card",
//               subtitle: "10880 Malibu Point Malibu Cal...\n•••• 1234",
//               leading: Assets.imagesCardType,
//               trailing: Icons.chevron_right,
//             ),
//             _ApplePayRow(
//               title: "Contact",
//               subtitle: "astark@starkindustries.com\n(123) 456-7890",
//               leading: Assets.imagesApplePay,
//               trailing: Icons.chevron_right,
//             ),
//             _ApplePayRow(
//               title: "Shipping",
//               subtitle: "Anthony Stark\n10880 Malibu Point\nMalibu CA 90263",
//               leading: Assets.imagesGPayIcon,
//               trailing: Icons.chevron_right,
//             ),
//             _ApplePayRow(
//               title: "Shipping",
//               subtitle: "Arrives 5-7 days",
//               leading: Assets.imagesAmericanExpressIcon,
//               trailing: Icons.chevron_right,
//             ),
//             SizedBox(height: h(context, 10)),
//             // CustomButton(
//             //   onPressed: () => Navigator.pop(context),
//             //   text: "Pay",
//             //   borderradius: 100,
//             //   size: 18,
//             //   weight: FontWeight.w500,
//             //   fontFamily: AppFonts.HelveticaNowDisplay,
//             //   color: kBlackColor,
//             //   height: 50,
//             //   width: double.maxFinite,
//             // ),
//             // SizedBox(height: h(context, 6)),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _ApplePayRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leading;
  final IconData? trailing;

  const _ApplePayRow({
    required this.title,
    required this.subtitle,
    required this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: h(context, 10)),
      padding: all(context, 14),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon(leading, color: kBlackColor),
          CommonImageView(imagePath: leading),
          SizedBox(width: w(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  size: 14,
                  weight: FontWeight.w700,
                  color: kBlackColor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
                SizedBox(height: h(context, 4)),
                CustomText(
                  text: subtitle,
                  size: 13,
                  weight: FontWeight.w500,
                  color: ktextcolor,
                  fontFamily: AppFonts.HelveticaNowDisplay,
                ),
              ],
            ),
          ),
          if (trailing != null) Icon(trailing, color: kBlackColor),
        ],
      ),
    );
  }
}

class CardInformationSheet extends StatefulWidget {
  const CardInformationSheet({super.key});

  @override
  State<CardInformationSheet> createState() => _CardInformationSheetState();
}

class _CardInformationSheetState extends State<CardInformationSheet> {
  final TextEditingController _cardNumber = TextEditingController(
    text: "**** **** **** *",
  );
  final TextEditingController _cardHolder = TextEditingController(
    text: "eg. kevin backer",
  );
  final TextEditingController _expiry = TextEditingController();
  final TextEditingController _cvv = TextEditingController();

  @override
  void dispose() {
    _cardNumber.dispose();
    _cardHolder.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF4F4F4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        w(context, 20),
        h(context, 14),
        w(context, 20),
        h(context, 20),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: h(context, 4),
                width: w(context, 40),
                margin: EdgeInsets.only(bottom: h(context, 12)),
                decoration: BoxDecoration(
                  color: kBlackColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, size: 20),
                      SizedBox(width: w(context, 6)),
                      CustomText(
                        text: "Back",
                        size: 14,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                        fontFamily: AppFonts.HelveticaNowDisplay,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 10)),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CustomText(
                    text: "Enter Card Information",
                    size: 20,
                    weight: FontWeight.w700,
                    color: kBlackColor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                  SizedBox(height: h(context, 4)),

                  CustomText(
                    textAlign: TextAlign.center,
                    text:
                        "Please enter the card information mention on your debit or credit card.",
                    size: 14,
                    weight: FontWeight.w500,
                    color: ktextcolor,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                  ),
                ],
              ),
            ),
            SizedBox(height: h(context, 18)),
            _InputLabel(text: "Card Number"),

            SizedBox(height: h(context, 6)),
            CustomLabelTextFeild(
              isLebal: false,
              controller: _cardNumber,
              label: "****, ****, ****, *",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: h(context, 12)),
            _InputLabel(text: "Card Holder Name"),
            SizedBox(height: h(context, 6)),
            CustomLabelTextFeild(
              isLebal: false,
              controller: _cardHolder,
              label: "eg. kevin backer",
            ),
            SizedBox(height: h(context, 12)),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputLabel(text: "Expiry Date"),
                      SizedBox(height: h(context, 6)),
                      CustomLabelTextFeild(
                        controller: _expiry,
                        label: "MM/YYYY",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: w(context, 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputLabel(text: "CVV"),
                      SizedBox(height: h(context, 6)),
                      CustomLabelTextFeild(
                        controller: _cvv,
                        label: "eg. 123",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 18)),
            CustomButton(
              onPressed: () {
                Get.to(() => ManageSubscriptionsScreen());
              },
              text: "Continue",
              borderradius: 100,
              size: 18,
              weight: FontWeight.w500,
              fontFamily: AppFonts.HelveticaNowDisplay,
              color: kBlackColor,
              height: 50,
              width: double.maxFinite,
            ),
            SizedBox(height: h(context, 6)),
          ],
        ),
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  final String text;
  const _InputLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: 14,
      weight: FontWeight.w600,
      color: kBlackColor.withValues(alpha: 0.7),
      fontFamily: AppFonts.HelveticaNowDisplay,
    );
  }
}
