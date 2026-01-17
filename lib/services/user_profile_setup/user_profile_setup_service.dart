import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userProfilleSetupSrvices {
  userProfilleSetupSrvices._internal();

  static final userProfilleSetupSrvices _instance =
      userProfilleSetupSrvices._internal();

  static userProfilleSetupSrvices get instance => _instance;

  /// ONLY observable variable
  final RxBool isUserExist = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _lastUserIdKey = 'last_user_id';

  /// Call on app start OR after login
  Future<void> checkIsUserRegistered({required String userId}) async {
    final prefs = await SharedPreferences.getInstance();

    // Save current userId locally
    await prefs.setString(_lastUserIdKey, userId);

    // Load user-specific value
    final storedValue = prefs.getBool(_userExistKey(userId));
    if (storedValue != null) {
      isUserExist.value = storedValue;
    } else {
      isUserExist.value = false;
    }
  }

  /// 🔥 MAIN METHOD
  /// Check if user profile exists in Firestore
  Future<void> checkUserProfile({required String userId}) async {
    try {
      final doc = await _firestore.collection('user').doc(userId).get();

      await _saveToLocal(userId, doc.exists);
    } catch (e) {
      await _saveToLocal(userId, false);
    }
  }

  /// Save per-user result locally
  Future<void> _saveToLocal(String userId, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userExistKey(userId), value);
    isUserExist.value = value;
  }

  /// Restore last logged-in user (optional helper)
  Future<void> restoreLastUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_lastUserIdKey);

    if (userId != null) {
      final value = prefs.getBool(_userExistKey(userId)) ?? false;
      isUserExist.value = value;
    }
  }

  /// Clear only current user (on logout)
  Future<void> clearCurrentUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userExistKey(userId));
    isUserExist.value = false;
  }

  /// Helper for user-specific key
  String _userExistKey(String userId) => 'user_exist_$userId';
}
