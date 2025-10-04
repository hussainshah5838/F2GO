import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/message_model.dart';

class ChatController extends GetxController {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    messages.addAll([
      MessageModel(
        text: "Hello there ! Hope you are doing well",
        isMe: false,
        type: MessageType.text,
        time: DateTime.now(),
      ),
      MessageModel(
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
        isMe: false,
        type: MessageType.text,
        time: DateTime.now(),
      ),
      MessageModel(
        text: "I’m doing good",
        isMe: true,
        type: MessageType.text,
        time: DateTime.now(),
      ),
    ]);
  }

  void sendText(String text) {
    messages.add(
      MessageModel(
        text: text,
        isMe: true,
        type: MessageType.text,
        time: DateTime.now(),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messages.add(
        MessageModel(
          imagePath: image.path,
          isMe: true,
          type: MessageType.image,
          time: DateTime.now(),
        ),
      );
    }
  }
}
