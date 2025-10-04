class MessageModel {
  final String? text;
  final String? imagePath;
  final bool isMe;
  final MessageType type;
  final DateTime time;

  MessageModel({
    this.text,
    this.imagePath,
    required this.isMe,
    required this.type,
    required this.time,
  });
}

enum MessageType { text, image }
