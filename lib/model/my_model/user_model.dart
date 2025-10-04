import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? bio;
  final String? email;
  final String? fcmToken;
  final String? authType;
  final String? profileImage;
  final DateTime? createdAt;

  UserModel({
    this.fullName,
    this.bio,
    this.email,
    this.fcmToken,
    this.authType,
    this.profileImage,
    this.createdAt,
  });

  /// Convert Firestore doc -> UserModel
  factory UserModel.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>?;
    if (map == null) return UserModel();

    return UserModel(
      fullName: map['fullName'] as String?,
      bio: map['bio'] as String?,
      email: map['email'] as String?,
      fcmToken: map['fcmToken'] as String?,
      authType: map['authType'] as String?,
      profileImage: map['profileImage'] as String?,
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : null,
    );
  }

  /// Convert UserModel -> Map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'bio': bio,
      'email': email,
      'fcmToken': fcmToken,
      'authType': authType,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }

  /// Check if any field contains a search term (case insensitive)
  bool contains(String query) {
    final lowerQuery = query.toLowerCase();
    return (fullName?.toLowerCase().contains(lowerQuery) ?? false) ||
        (bio?.toLowerCase().contains(lowerQuery) ?? false) ||
        (email?.toLowerCase().contains(lowerQuery) ?? false) ||
        (fcmToken?.toLowerCase().contains(lowerQuery) ?? false) ||
        (authType?.toLowerCase().contains(lowerQuery) ?? false) ||
        (profileImage?.toLowerCase().contains(lowerQuery) ?? false) ||
        (createdAt?.toIso8601String().toLowerCase().contains(lowerQuery) ??
            false);
  }
}
