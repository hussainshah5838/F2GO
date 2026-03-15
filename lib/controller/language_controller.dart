import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt myIndex = 0.obs;

  Rx<Locale> currentLang = const Locale('en', 'US').obs;

  static const _langCodeKey = 'lang_code';
  static const _countryCodeKey = 'country_code';
  static const _indexKey = 'lang_index';

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void changeLanguage(String langCode, String countryCode, int index) async {
    final locale = Locale(langCode, countryCode);
    currentLang.value = locale;
    currentIndex.value = index;

    Get.updateLocale(locale);

    await _saveLanguage(langCode, countryCode, index);
  }

  Future<void> _saveLanguage(
    String langCode,
    String countryCode,
    int index,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langCodeKey, langCode);
    await prefs.setString(_countryCodeKey, countryCode);
    await prefs.setInt(_indexKey, index);
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    final langCode = prefs.getString(_langCodeKey) ?? 'en';
    final countryCode = prefs.getString(_countryCodeKey) ?? 'US';
    final index = prefs.getInt(_indexKey) ?? 0;

    final locale = Locale(langCode, countryCode);

    currentLang.value = locale;
    currentIndex.value = index;
    Get.updateLocale(locale);
  }
}
