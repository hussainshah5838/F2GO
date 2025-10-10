import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_images.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/my_ctrl/chat_controller.dart';
import 'package:f2g/core/enums/message_type.dart';
import 'package:f2g/main.dart';
import 'package:f2g/model/my_model/chat/message_model.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/services/date_formator/general_service.dart';
import 'package:f2g/services/user/user_services.dart';
import 'package:f2g/view/screens/plans/view_picture.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  String chatHeadID;
  ChatScreen({super.key, required this.chatHeadID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController controller = Get.find<ChatController>();

  final args = Get.arguments as Map<String, dynamic>;

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom(); // Scroll to bottom when chat opens
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Stream<QuerySnapshot> getMessagesStream() {
    return chatCollection
        .doc(widget.chatHeadID)
        .collection("messages")
        .orderBy("sentAt", descending: false) // Natural chat order
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    PlanModel planModel = args['data'];
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    h(context, 100),
                                  ),
                                  child: CommonImageView(
                                    url: planModel.planPhoto,
                                    height: 36,
                                    width: 36,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                CustomText(
                                  text: "${planModel.title}",
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

                  // Container(
                  //   height: h(context, 25),
                  //   padding: symmetric(context, horizontal: 10),
                  //   decoration: BoxDecoration(
                  //     color: kWhiteColor,
                  //     borderRadius: BorderRadius.circular(h(context, 8)),
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       CustomText(
                  //         text: "Yesterday",
                  //         size: 12,
                  //         weight: FontWeight.w500,
                  //         color: ktextcolor,
                  //         fontFamily: AppFonts.HelveticaNowDisplay,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Expanded(
                  //   child: Obx(
                  //     () => ListView.builder(
                  //       padding: symmetric(
                  //         context,
                  //         horizontal: 20,
                  //         vertical: 40,
                  //       ),
                  //       itemCount: controller.messages.length,
                  //       itemBuilder: (context, index) {
                  //         final message = controller.messages[index];
                  //         return Align(
                  //           alignment:
                  //               message.isMe
                  //                   ? Alignment.centerRight
                  //                   : Alignment.centerLeft,
                  //           child: Column(
                  //             crossAxisAlignment:
                  //                 message.isMe
                  //                     ? CrossAxisAlignment.end
                  //                     : CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 margin: only(
                  //                   context,
                  //                   bottom: 6,
                  //                   left: message.isMe ? 50 : 0,
                  //                   right: message.isMe ? 0 : 50,
                  //                 ),
                  //                 padding: only(
                  //                   context,
                  //                   left: 12,
                  //                   right: 10,
                  //                   top: 10,
                  //                   bottom: 10,
                  //                 ),
                  //                 decoration: BoxDecoration(
                  //                   color:
                  //                       message.isMe
                  //                           ? kSecondaryColor
                  //                           : kWhiteColor,
                  //                   borderRadius: BorderRadius.circular(
                  //                     h(context, 12),
                  //                   ),
                  //                 ),
                  //                 child:
                  //                     message.type == MessageType.text
                  //                         ? CustomText(
                  //                           text: message.text ?? "",
                  //                           size: 14,
                  //                           weight: FontWeight.w500,
                  //                           color:
                  //                               message.isMe
                  //                                   ? kWhiteColor
                  //                                   : kBlackColor,
                  //                           fontFamily:
                  //                               AppFonts.HelveticaNowDisplay,
                  //                         )
                  //                         : ClipRRect(
                  //                           borderRadius: BorderRadius.circular(
                  //                             h(context, 8),
                  //                           ),
                  //                           child: CommonImageView(
                  //                             imagePath:
                  //                                 message.imagePath ?? "",
                  //                             height: h(context, 150),
                  //                             width: w(context, 200),
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //               ),
                  //               Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   CustomText(
                  //                     text: _formatTime(message.time),
                  //                     size: 10,
                  //                     weight: FontWeight.w500,
                  //                     color: ktextcolor,
                  //                     fontFamily: AppFonts.HelveticaNowDisplay,
                  //                   ),

                  //                   SizedBox(width: w(context, 4)),
                  //                   CommonImageView(
                  //                     imagePath: Assets.imagesReadicon,
                  //                     height: 16,
                  //                     width: 16,
                  //                     fit: BoxFit.contain,
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(height: h(context, 6)),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),

                  // --------------------------------------------
                  // --------------------------------------------
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: getMessagesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No messages yet"));
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 70),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel msg = MessageModel.fromMap(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>,
                            );

                            // bool isCurrentUserMsg = (UserService.instance
                            //             .instance.userType ==
                            //         UserType.therapist.name)
                            //     ? UserService.instance.therapistDetailModel.value.id ==
                            //         snapshot.data!.docs[index]['sentBy']
                            //     : UserService.instance.userModel.value.id ==
                            //         snapshot.data!.docs[index]['sentBy'];

                            bool isCurrentUserMsg =
                                auth.currentUser?.uid ==
                                snapshot.data!.docs[index]['sentBy'];

                            // log('$isCurrentUserMsg');

                            // log(" other image : ${widget.profileImage}");
                            // log(" other name : ${widget.userName}");

                            return ChatBubble(
                              isMe:
                                  msg.sentBy ==
                                  // UserService.instance.userModel.value.id
                                  auth.currentUser?.uid.toString(),
                              myImg: dummyimage,
                              msg: msg.textMessage ?? "",
                              otherUserImg: dummyImg,
                              //     widget.profileImage ?? dummyimage,
                              otherUserName: msg.senderName ?? "Unknown",
                              msgTime:
                                  msg.sentAt != null
                                      ? DateTimeService.instance
                                          .formatTimeToAMPMTakingAsDateTime(
                                            msg.sentAt!,
                                          )
                                      // .formatTimeToAMPM(msg.sentAt!)
                                      : "",
                              haveImages:
                                  (msg.messageType == MsgType.picture_msg.name)
                                      ? true
                                      : false,
                              imageUrl: msg.pictureMedia,
                              onImageTap: () {
                                Get.to(
                                  () => ViewPicture(
                                    imageUrl: msg.pictureMedia.toString(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // --------------------------------------------
                  // --------------------------------------------
                ],
              ),
            ),
          ],
        ),
        bottomSheet: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // -------- If Image picked from gallery --------
                (controller.selectedImage.value != null)
                    ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 17,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Display Image
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(
                                  File(controller.selectedImage.value!),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.selectedImage.value = null;
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: kWhiteColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Send Image button
                          GestureDetector(
                            onTap: () {
                              log('Press');

                              final user = UserService.instance.userModel.value;

                              controller.messagesPictureHandler(
                                type: MsgType.picture_msg.name,
                                senderID: auth.currentUser!.uid,
                                // user.id.toString(),
                                senderName: user.fullName.toString(),
                                senderProfileImage:
                                    user.profileImage.toString(),
                                threadID: widget.chatHeadID,
                              );

                              _scrollToBottom();
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: kWhiteColor),
                                color: kWhiteColor,
                              ),
                              child: Center(
                                child:
                                    (controller.isLoading.value)
                                        ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: kSecondaryColor,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                        : CommonImageView(
                                          imagePath: Assets.imagesSendbutton,
                                          height: 44,
                                          width: 44,
                                          fit: BoxFit.contain,
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : SendField(
                      controller: controller.textMessageController,
                      haveSendButton: true,
                      isLoading: controller.isLoading.value,
                      onAttachmentTap: () {
                        Get.bottomSheet(_MoreContent());
                      },
                      onSendTap: () async {
                        log("My Terrible Code");

                        log("1");
                        final user = UserService.instance.userModel.value;

                        if (controller.isLoading.value == false) {
                          if (controller.textMessageController.text
                              .trim()
                              .isNotEmpty) {
                            controller.messagesHandler(
                              type: MsgType.text_msg.name,
                              senderID: auth.currentUser?.uid ?? "",
                              senderName: user.fullName.toString(),
                              senderProfileImage: dummyImg,
                              // user.profilePicture.toString() ?? dummyimage,
                              threadID: widget.chatHeadID,
                              newMessage:
                                  controller.textMessageController.text.trim(),
                            );

                            _scrollToBottom();
                          }
                        } else {
                          log("------> My Terrible Therapist");
                        }
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

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.isMe,
    required this.otherUserImg,
    required this.otherUserName,
    required this.msgTime,
    required this.msg,
    required this.myImg,
    required this.haveImages,
    this.onImageTap,

    // required this.images,
    this.imageUrl,
  }) : super(key: key);

  final String msg, otherUserName, otherUserImg, msgTime, myImg;
  final bool isMe, haveImages;
  // final List<String> images;
  final String? imageUrl;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    if (haveImages) {
      return isMe ? _rightImageBubble() : _leftImageBubble();
    } else {
      return isMe ? _rightMessageBubble() : _leftMessageBubble();
    }
  }

  Widget _rightMessageBubble() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  msgTime,
                  style: TextStyle(fontSize: 12, color: kBlackColor),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        text: msg,
                        size: 13,
                        color: kPrimaryColor,
                        paddingBottom: 5,
                      ),
                      // Text(
                      //   msgTime,
                      //   style: TextStyle(
                      //     fontSize: 10,
                      //     color: korange1,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.31),
          // _profileImage(dummyImg),
        ],
      ),
    );
  }

  Widget _leftMessageBubble() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _profileImage(otherUserImg),
          SizedBox(width: 10.39),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  child: Container(
                    margin: EdgeInsets.only(right: 49.48),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: MyText(
                        //     text: otherUserName,
                        //     size: 11,
                        //     weight: FontWeight.w600,
                        //     color: korange,
                        //     paddingBottom: 10.32,
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(msgTime, style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: msg,
                            size: 14,
                            weight: FontWeight.w400,
                            color: kBlackColor,
                            paddingTop: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _leftImageBubble() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _profileImage(otherUserImg),
            SizedBox(width: 10.39),

            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 4.13,
            //       mainAxisSpacing: 4.13,
            //       mainAxisExtent: 103.23,
            //     ),
            //     physics: BouncingScrollPhysics(),
            //     itemCount: images.length,
            //     padding: EdgeInsets.zero,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return CommonImageView(
            //         height: 103.23,
            //         width: 103.23,
            //         radius: 4.13,
            //         url: images[index],
            //       );
            //     },
            //   ),
            // ),
            Visibility(
              visible: haveImages,
              child: InkWell(
                onTap: onImageTap,
                child: CommonImageView(
                  height: 103.23,
                  width: 103.23,
                  radius: 4.13,
                  url: imageUrl,
                ),
              ),
            ),
            SizedBox(width: 49.48),
          ],
        ),
      ),
    );
  }

  Widget _rightImageBubble() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SizedBox(width: 49.48),
          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 4.13,
          //       mainAxisSpacing: 4.13,
          //       mainAxisExtent: 103.23,
          //     ),
          //     physics: BouncingScrollPhysics(),
          //     itemCount: images.length,
          //     padding: EdgeInsets.zero,
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return CommonImageView(
          //         height: 103.23,
          //         width: 103.23,
          //         radius: 4.13,
          //         url: images[index],
          //       );
          //     },
          //   ),
          // ),
          Visibility(
            visible: haveImages,
            child: InkWell(
              onTap: onImageTap,
              child: CommonImageView(
                height: 103.23,
                width: 103.23,
                radius: 4.13,
                url: imageUrl,
              ),
            ),
          ),
          SizedBox(width: 10.31),
          // _profileImage(dummyImg),
        ],
      ),
    );
  }

  Widget _profileImage(String url) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CommonImageView(
          height: 41.29,
          width: 41.29,
          url: url,
          fit: BoxFit.cover,
          radius: 100,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 11.84,
            width: 11.84,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.97,
                // color: kPrimaryColor,
                color: Colors.transparent,
              ),
              shape: BoxShape.circle,
              // color: kSecondaryColor,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

class SendField extends StatelessWidget {
  SendField({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.validator,
    this.onAttachmentTap,
    this.onEmojiTap,
    this.haveSendButton = false,
    this.isLoading = false,
    this.onSendTap,
  }) : super(key: key);
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEmojiTap, onAttachmentTap, onSendTap;
  final bool haveSendButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border(top: BorderSide(color: Color(0xffEDEDED), width: 1.0)),
      ),
      child: Row(
        children: [
          SizedBox(width: w(context, 8)),
          Expanded(
            child: Container(
              padding: symmetric(context, horizontal: 14),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(h(context, 12)),
              ),
              child: Row(
                children: [
                  SizedBox(width: w(context, 8)),
                  Expanded(
                    child: TextFormField(
                      cursorColor: kBlackColor,
                      controller: controller,
                      // controller:
                      //     textControllers.messageController.value,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: f(context, 12),
                          fontWeight: FontWeight.w500,
                          color: kBlackColor.withValues(alpha: 0.5),
                          fontFamily: AppFonts.HelveticaNowDisplay,
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
                  // ----------------------------------------------------------
                  // ----------------------------------------------------------
                  // ----------------------------------------------------------
                  // ----------------------------------------------------------
                  // ----------------------------------------------------------
                  // ----------------------------------------------------------
                  SizedBox(width: w(context, 8)),
                  InkWell(
                    onTap: onAttachmentTap,
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
          // Expanded(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(50),
          //     child: TextFormField(
          //       cursorColor: Colors.black,
          //       // textAlignVertical: TextAlignVertical.center,
          //       controller: controller,
          //       onTap: onTap,
          //       onChanged: onChanged,
          //       validator: validator,
          //       autovalidateMode: AutovalidateMode.always,
          //       cursorWidth: 1.0,
          //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: kSecondaryColor,
          //         hintText: 'Write a message...',
          //         hintStyle: TextStyle(
          //           fontSize: 13,
          //           fontWeight: FontWeight.w400,
          //         ),
          //         contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //         // suffixIcon: Column(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   children: [
          //         //     GestureDetector(
          //         //       onTap: onAttachmentTap,
          //         //       child: Image.asset(
          //         //         Assets.imagesMic,
          //         //         height: 23.99,
          //         //         color: kSecondaryColor,
          //         //       ),
          //         //     ),
          //         //   ],
          //         // ),
          //         border: InputBorder.none,
          //         enabledBorder: InputBorder.none,
          //         focusedBorder: InputBorder.none,
          //         errorBorder: InputBorder.none,
          //         focusedErrorBorder: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(width: 8),
          // GestureDetector(
          //   onTap: onAttachmentTap,
          //   child: Container(
          //     width: 48,
          //     height: 48,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: kSecondaryColor,
          //     ),
          //     child: Center(
          //       child: Icon(Icons.camera_alt_outlined, color: kBlackColor),
          //       // child: Image.asset(
          //       //   Assets.imagesAttachment,
          //       //   height: 23.99,
          //       //   color: kSecondaryColor,
          //       // ),
          //     ),
          //   ),
          // ),
          SizedBox(width: 8),
          (haveSendButton)
              ? InkWell(
                onTap: onSendTap,
                child:
                    (isLoading)
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: kSecondaryColor,
                            strokeWidth: 2.0,
                          ),
                        )
                        : CommonImageView(
                          imagePath: Assets.imagesSendbutton,
                          height: 44,
                          width: 44,
                          fit: BoxFit.contain,
                        ),
              )
              : SizedBox.shrink(),

          // GestureDetector(
          //   onTap: onSendTap,
          //   child: Container(
          //     width: 48,
          //     height: 48,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: kBlackColor,
          //     ),
          //     child: Center(
          //       child:
          //           (isLoading)
          //               ? SizedBox(
          //                 height: 20,
          //                 width: 20,
          //                 child: CircularProgressIndicator(
          //                   color: kWhiteColor,
          //                   strokeWidth: 2.0,
          //                 ),
          //               )
          //               : Icon(Icons.send, color: kWhiteColor),
          //       //  Image.asset(
          //       //   Assets.imagesMic,
          //       //   height: 23.99,
          //       //   color: kSecondaryColor,
          //       // ),
          //     ),
          //   ),
          // )
          // : SizedBox(),
          // : GestureDetector(
          //     onTap: onAttachmentTap,
          //     child: Container(
          //       width: 48,
          //       height: 48,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: kWhiteColor,
          //       ),
          //       child: Center(
          //         child: Image.asset(
          //           Assets.imagesMic,
          //           height: 23.99,
          //           color: korange,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class _MoreContent extends StatefulWidget {
  const _MoreContent({super.key});

  @override
  State<_MoreContent> createState() => _MoreContentState();
}

class _MoreContentState extends State<_MoreContent> {
  var ctrl = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kBlackColor.withValues(alpha: 0.2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MoreButton(
                icon: Icons.photo,
                text: 'Gallery',
                onTap: () {
                  ctrl.imageFromGallery();
                },
              ),
              _MoreButton(
                text: 'Camera',
                onTap: () {
                  ctrl.imageFromCamera();
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onTap;
  const _MoreButton({super.key, this.icon, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon ?? Icons.camera, color: kWhiteColor),
          ),
        ),
        CustomText(paddingTop: 5, text: '$text', color: kBlackColor),
      ],
    );
  }
}
