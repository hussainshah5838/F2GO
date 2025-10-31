class NotificationModel {
  DateTime? createdAt;
  String? imageUrl;
  String? link;
  Result? result;
  DateTime? sentAt;
  String? status;
  String? targetType;
  String? text;
  String? title;
  String? topic;
  List<String>? userIds;

  NotificationModel({
    this.createdAt,
    this.imageUrl,
    this.link,
    this.result,
    this.sentAt,
    this.status,
    this.targetType,
    this.text,
    this.title,
    this.topic,
    this.userIds,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'].toString())
              : null,
      imageUrl: json['imageUrl'] as String?,
      link: json['link'] as String?,
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
      sentAt:
          json['sentAt'] != null
              ? DateTime.tryParse(json['sentAt'].toString())
              : null,
      status: json['status'] as String?,
      targetType: json['targetType'] as String?,
      text: json['text'] as String?,
      title: json['title'] as String?,
      topic: json['topic'] as String?,
      userIds: (json['userIds'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'imageUrl': imageUrl,
      'link': link,
      'result': result?.toJson(),
      'sentAt': sentAt?.toIso8601String(),
      'status': status,
      'targetType': targetType,
      'text': text,
      'title': title,
      'topic': topic,
      'userIds': userIds,
    };
  }

  /// ✅ Safe keyword check (avoids nulls)
  bool contains(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    return (status?.toLowerCase().contains(lowerKeyword) ?? false) ||
        (targetType?.toLowerCase().contains(lowerKeyword) ?? false) ||
        (text?.toLowerCase().contains(lowerKeyword) ?? false) ||
        (title?.toLowerCase().contains(lowerKeyword) ?? false) ||
        (topic?.toLowerCase().contains(lowerKeyword) ?? false) ||
        (userIds?.any((id) => id.toLowerCase().contains(lowerKeyword)) ??
            false);
  }
}

class Result {
  int? cleaned;
  int? failure;
  int? success;
  DateTime? scheduledAt;

  Result({this.cleaned, this.failure, this.success, this.scheduledAt});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      cleaned: json['cleaned'] as int?,
      failure: json['failure'] as int?,
      success: json['success'] as int?,
      scheduledAt:
          json['scheduledAt'] != null
              ? DateTime.tryParse(json['scheduledAt'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cleaned': cleaned,
      'failure': failure,
      'success': success,
      'scheduledAt': scheduledAt?.toIso8601String(),
    };
  }
}
