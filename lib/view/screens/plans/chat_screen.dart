import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/chat_contorller.dart';
import '../../../model/message_model.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  // final TextControllers textControllers = Get.find<TextControllers>();
  ChatScreen({super.key});

  final args = Get.arguments as Map<String, dynamic>;

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    // final FavouriteModel data = args['data'];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),

            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: h(context, 20)),
                  Padding(
                    padding: symmetric(context, horizontal: 20),
                    child: Row(
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
                          child: Container(
                            padding: symmetric(context, horizontal: 10),
                            height: h(context, 46),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                h(context, 10),
                              ),
                              color: kWhiteColor,
                            ),

                            child: Row(
                              children: [
                                // ClipRRect(
                                //   // borderRadius: BorderRadiusGeometry.circular(
                                //   //   h(context, 100),
                                //   // ),
                                //   child: CommonImageView(
                                //     imagePath: data.image,
                                //     height: 36,
                                //     width: 36,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                CustomText(
                                  // text: data.title,
                                  text: " UP Image data.title",
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                  size: 16,
                                  paddingLeft: 6,
                                  weight: FontWeight.w500,
                                  color: kBlackColor,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h(context, 10)),
                  Container(
                    height: h(context, 25),
                    padding: symmetric(context, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(h(context, 8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: "Yesterday",
                          size: 12,
                          weight: FontWeight.w500,
                          color: ktextcolor,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        padding: symmetric(
                          context,
                          horizontal: 20,
                          vertical: 40,
                        ),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          return Align(
                            alignment:
                                message.isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment:
                                  message.isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: only(
                                    context,
                                    bottom: 6,
                                    left: message.isMe ? 50 : 0,
                                    right: message.isMe ? 0 : 50,
                                  ),
                                  padding: only(
                                    context,
                                    left: 12,
                                    right: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        message.isMe
                                            ? kSecondaryColor
                                            : kWhiteColor,
                                    borderRadius: BorderRadius.circular(
                                      h(context, 12),
                                    ),
                                  ),
                                  child:
                                      message.type == MessageType.text
                                          ? CustomText(
                                            text: message.text ?? "",
                                            size: 14,
                                            weight: FontWeight.w500,
                                            color:
                                                message.isMe
                                                    ? kWhiteColor
                                                    : kBlackColor,
                                            fontFamily:
                                                AppFonts.HelveticaNowDisplay,
                                          )
                                          : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              h(context, 8),
                                            ),
                                            child: CommonImageView(
                                              imagePath:
                                                  message.imagePath ?? "",
                                              height: h(context, 150),
                                              width: w(context, 200),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: _formatTime(message.time),
                                      size: 10,
                                      weight: FontWeight.w500,
                                      color: ktextcolor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                    ),

                                    SizedBox(width: w(context, 4)),
                                    CommonImageView(
                                      imagePath: Assets.imagesReadicon,
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                                SizedBox(height: h(context, 6)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Container(
                    padding: symmetric(context, horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(color: kWhiteColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: symmetric(context, horizontal: 14),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(
                                h(context, 12),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: w(context, 8)),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: kBlackColor,
                                    controller: TextEditingController(),
                                    // controller:
                                    //     textControllers.messageController.value,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize: f(context, 12),
                                        fontWeight: FontWeight.w500,
                                        color: kBlackColor.withValues(
                                          alpha: 0.5,
                                        ),
                                        fontFamily:
                                            AppFonts.HelveticaNowDisplay,
                                      ),
                                      hintText: "Type your message here...",
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize: f(context, 14),
                                      fontWeight: FontWeight.w500,
                                      color: kBlackColor,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                    ),
                                  ),
                                ),
                                SizedBox(width: w(context, 8)),
                                InkWell(
                                  onTap: controller.pickImage,
                                  child: CommonImageView(
                                    imagePath: Assets.imagesCameraicon,
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: w(context, 7)),
                        InkWell(
                          onTap: () {
                            // if (textControllers.messageController.value.text
                            //     .trim()
                            //     .isNotEmpty) {
                            //   controller.sendText(
                            //     textControllers.messageController.value.text
                            //         .trim(),
                            //   );
                            //   textControllers.messageController.value.clear();
                            // }
                          },
                          child: CommonImageView(
                            imagePath: Assets.imagesSendbutton,
                            height: 44,
                            width: 44,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
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
