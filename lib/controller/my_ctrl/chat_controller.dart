import 'dart:developer';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/model/my_model/chat/chat_thread_model.dart';
import 'package:f2g/model/my_model/chat/message_model.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
import 'package:f2g/services/image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  TextEditingController textMessageController = TextEditingController();

  TextEditingController filterController = TextEditingController();
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  // Image Selection
  Rxn<String> selectedImage = Rxn<String>(null);
  RxBool isChatHeadExists = false.obs;
  RxList<UserModel> chatThreadTempList = <UserModel>[].obs;
  RxList<UserModel> filterChatThreads = <UserModel>[].obs;

  // ---------------- Creating Chat Thread Model ---------------------

  Future<void> creatingChatThread({
    required String myID,
    required String chatID,
  }) async {
    try {
      showLoadingDialog();

      DateTime currentDateTime = DateTime.now();
      // String chatThreadId = "$myID-$participantsID";
      ChatThreadModel chatThreadModel = ChatThreadModel(
        createdAt: currentDateTime,
        chatType: 'group-chat',
        lastMessage: '',
        lastMessageType: '',
        unSeenMessage: false,
        lastMessageSeenBy: [],
        likedBy: [],
        deletedBy: [],
        participants: [myID],
        receiverImage: '',
        receiverName: '',
        chatThreadId: chatID,
        receiverID: '',
      );

      await chatCollection.doc(chatID).set(chatThreadModel.toMap());

      log('Chat-thread created');

      hideLoadingDialog();
    } catch (e) {
      log('Chat-thread Error while creating: -----> $e');
      hideLoadingDialog();
    }
  }

  // -------> Update chat thread <----------

  Future<void> updateChatThread({
    required String chatThreadId,
    required String chatImage,
    required String chatName,
    required DateTime lastMessageTime,
    required String lastMessageType,
    required bool unSeenMessage,
    String? lastTextMessage,
  }) async {
    try {
      await chatCollection.doc(chatThreadId).update({
        // 'eventImage': eventImage,
        'chatThreadId': chatThreadId,
        'chatName': chatName,
        'chatImage': chatImage,
        'lastMessageTime': lastMessageTime,
        'lastMessage': lastTextMessage,
        'lastMessageType': lastMessageType,
        'unSeenMessage': unSeenMessage,
      });

      log('---> Chat thread Updated <---');
    } catch (e) {
      log('Error Occurs during updating chat thread: ---> $e');
    }
  }

  Future<void> messagesHandler({
    required dynamic type,
    required String senderID,
    required String senderName,
    required String senderProfileImage,
    required String threadID,
    String? newMessage,
  }) async {
    try {
      isLoading.value = true;

      String newDocId = uuid.v4();

      MessageModel msgModel = MessageModel(
        sentBy: senderID,
        sentAt: DateTime.now(),
        senderName: senderName,
        senderProfileImage: senderProfileImage,
        messageId: newDocId,
        // messageType: type,
        textMessage: textMessageController.text.trim(),
        isSeen: false,
        seenBy: [],
        deletedBy: [],
      );

      await chatCollection
          .doc(threadID)
          .collection('messages')
          .doc(newDocId)
          .set(msgModel.toMap());

      await updateChatThread(
        chatThreadId: threadID,
        lastTextMessage: textMessageController.text.trim(),
        lastMessageTime: DateTime.now(),
        chatImage: senderProfileImage,
        chatName: senderName,
        lastMessageType: type,
        unSeenMessage: false,
      );

      log("Message send");

      textMessageController.clear();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("Message sending erorr: $e");
    }
  }

  // --------- Image Type Chat -------------

  Future<void> imageFromGallery() async {
    await ImagePickerService().pickMedia(isImage: true, fromGallery: true);
    selectedImage.value = ImagePickerService().activeMedia.value;
    Get.close(1);
  }

  Future<void> imageFromCamera() async {
    await ImagePickerService().pickMedia(isImage: true, fromGallery: false);
    selectedImage.value = ImagePickerService().activeMedia.value;
    Get.close(1);
  }

  // Image from gallery

  Future<void> messagesPictureHandler({
    required dynamic type,
    required String senderID,
    required String senderName,
    required String senderProfileImage,
    required String threadID,
  }) async {
    try {
      isLoading.value = true;

      String newDocId = uuid.v4();

      String? downloadImageUrl;
      if (selectedImage.value != null) {
        downloadImageUrl = await FirebaseStorageService.instance.uploadImage(
          imagePath: selectedImage.value!,
          storageFolderPath: 'chat_images',
        );
      }
      log('download url is: $downloadImageUrl');

      MessageModel msgModel = MessageModel(
        sentBy: senderID,
        sentAt: DateTime.now(),
        senderName: senderName,
        senderProfileImage: senderProfileImage,
        messageId: newDocId,
        messageType: type,
        pictureMedia: downloadImageUrl,
        isSeen: false,
        textMessage: '',
        seenBy: [],
        deletedBy: [],
      );

      await chatCollection
          .doc(threadID)
          .collection('messages')
          .doc(newDocId)
          .set(msgModel.toMap());

      await updateChatThread(
        chatThreadId: threadID,
        lastTextMessage: 'Picture',
        lastMessageTime: DateTime.now(),
        chatImage: senderProfileImage,
        chatName: senderName,
        lastMessageType: type,
        unSeenMessage: false,
      );

      log("Picture Message send");
      selectedImage.value = null;
      downloadImageUrl = null;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log("Message sending erorr: $e");
    }
  }

  // ---------------- Checking is ChatHead exist or not ---------------------

  Future<void> isChatHeadExist({
    required String myId,
    required String opponentId,
  }) async {
    try {
      isChatHeadExists.value = false;
      // Query where 'participants' array contains myId
      final querySnapshot =
          await chatCollection.where('participants', arrayContains: myId).get();

      // Iterate over results to check if opponentId also exists
      for (var doc in querySnapshot.docs) {
        final chatThread = ChatThreadModel.fromMap(doc);
        if (chatThread.participants.contains(opponentId)) {
          // Chat already exists
          isChatHeadExists.value = true;
          log("✅ Chat HeadExists.");
        }
      }
    } catch (e) {
      log("❌ Error checking chat head: $e");
      isChatHeadExists.value = false;
    }
  }

  // ------- Filter Chat Controller ----------

  void filterChatMethod({
    required List<UserModel> allChats,
    required String query,
  }) {
    if (query.isEmpty) {
      filterChatThreads.assignAll(allChats); // show all if nothing typed
      return;
    }

    final lowerQuery = query.toLowerCase().trim();

    // Check for exact match first
    final exactMatch =
        allChats
            .where(
              (child) => (child.fullName ?? '').toLowerCase() == lowerQuery,
            )
            .toList();

    if (exactMatch.isNotEmpty) {
      filterChatThreads.assignAll(exactMatch); // show only the exact match
      return;
    }

    // Otherwise, filter by partial match
    final partialMatches =
        allChats
            .where(
              (child) =>
                  (child.fullName ?? '').toLowerCase().contains(lowerQuery),
            )
            .toList();

    filterChatThreads.assignAll(partialMatches);
    log("Filter List Length is: ${filterChatThreads.length} ");
  }
}
