// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String? fullName;
//   final String? bio;
//   final String? email;
//   final String? fcmToken;
//   final String? authType;
//   final String? profileImage;
//   final DateTime? createdAt;

//   UserModel({
//     this.fullName,
//     this.bio,
//     this.email,
//     this.fcmToken,
//     this.authType,
//     this.profileImage,
//     this.createdAt,
//   });

//   /// Convert Firestore doc -> UserModel
//   factory UserModel.fromMap(DocumentSnapshot doc) {
//     final map = doc.data() as Map<String, dynamic>?;
//     if (map == null) return UserModel();

//     return UserModel(
//       fullName: map['fullName'] as String?,
//       bio: map['bio'] as String?,
//       email: map['email'] as String?,
//       fcmToken: map['fcmToken'] as String?,
//       authType: map['authType'] as String?,
//       profileImage: map['profileImage'] as String?,
//       createdAt:
//           map['createdAt'] != null
//               ? (map['createdAt'] as Timestamp).toDate()
//               : null,
//     );
//   }

//   /// Convert UserModel -> Map (Firestore)
//   Map<String, dynamic> toMap() {
//     return {
//       'fullName': fullName,
//       'bio': bio,
//       'email': email,
//       'fcmToken': fcmToken,
//       'authType': authType,
//       'profileImage': profileImage,
//       'createdAt': createdAt,
//     };
//   }

//   /// Check if any field contains a search term (case insensitive)
//   bool contains(String query) {
//     final lowerQuery = query.toLowerCase();
//     return (fullName?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (bio?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (email?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (fcmToken?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (authType?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (profileImage?.toLowerCase().contains(lowerQuery) ?? false) ||
//         (createdAt?.toIso8601String().toLowerCase().contains(lowerQuery) ??
//             false);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? id;
  final String? bio;
  final String? email;
  final String? fcmToken;
  final String? authType;
  final String? profileImage;
  final DateTime? createdAt;

  // New fields
  final String? gender;
  final String? dob;
  final String? location;
  final String? emergencyName;
  final String? emergencyContactNo;
  final String? emergencyRelation;

  UserModel({
    this.fullName,
    this.id,
    this.bio,
    this.email,
    this.fcmToken,
    this.authType,
    this.profileImage,
    this.createdAt,
    this.gender,
    this.dob,
    this.location,
    this.emergencyName,
    this.emergencyContactNo,
    this.emergencyRelation,
  });

  /// Firestore -> UserModel
  factory UserModel.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>?;
    if (map == null) return UserModel();

    return UserModel(
      fullName: map['fullName'] as String?,
      id: map['id'] as String?,
      bio: map['bio'] as String?,
      email: map['email'] as String?,
      fcmToken: map['fcmToken'] as String?,
      authType: map['authType'] as String?,
      profileImage: map['profileImage'] as String?,
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : null,

      // New fields
      gender: map['gender'] as String?,
      dob: map['dob'] as String?,
      location: map['location'] as String?,
      emergencyName: map['emergencyName'] as String?,
      emergencyContactNo: map['emergencyContactNo'] as String?,
      emergencyRelation: map['emergencyRelation'] as String?,
    );
  }

  /// UserModel -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'id': id,
      'bio': bio,
      'email': email,
      'fcmToken': fcmToken,
      'authType': authType,
      'profileImage': profileImage,
      'createdAt': createdAt,

      // New fields
      'gender': gender,
      'dob': dob,
      'location': location,
      'emergencyName': emergencyName,
      'emergencyContactNo': emergencyContactNo,
      'emergencyRelation': emergencyRelation,
    };
  }

  /// Search helper (null-safe & case-insensitive)
  bool contains(String query) {
    final q = query.toLowerCase();

    return (fullName?.toLowerCase().contains(q) ?? false) ||
        (bio?.toLowerCase().contains(q) ?? false) ||
        (email?.toLowerCase().contains(q) ?? false) ||
        (fcmToken?.toLowerCase().contains(q) ?? false) ||
        (authType?.toLowerCase().contains(q) ?? false) ||
        (profileImage?.toLowerCase().contains(q) ?? false) ||
        (gender?.toLowerCase().contains(q) ?? false) ||
        (dob?.toLowerCase().contains(q) ?? false) ||
        (location?.toLowerCase().contains(q) ?? false) ||
        (emergencyName?.toLowerCase().contains(q) ?? false) ||
        (emergencyContactNo?.toLowerCase().contains(q) ?? false) ||
        (emergencyRelation?.toLowerCase().contains(q) ?? false) ||
        (createdAt?.toIso8601String().toLowerCase().contains(q) ?? false);
  }
}
