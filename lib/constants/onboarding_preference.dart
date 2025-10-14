import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreference {
  static const String key = 'isOnboardingCompleted';

  /// Save onboarding completion
  static Future<void> setOnboardingComplete(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  /// Get onboarding status
  static Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
