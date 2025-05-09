import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  late SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Storage keys
  static const String themeKey = 'theme_mode';
  static const String userKey = 'current_user';
  static const String tokenKey = 'auth_token';
  static const String onboardingKey = 'onboarding_completed';
  static const String languageKey = 'app_language';
  static const String userTypeKey = 'user_type';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme storage
  Future<void> setThemeMode(String theme) async {
    await _prefs.setString(themeKey, theme);
  }

  String? getThemeMode() {
    return _prefs.getString(themeKey);
  }

  // User preferences
  Future<void> setLanguage(String language) async {
    await _prefs.setString(languageKey, language);
  }

  String getLanguage() {
    return _prefs.getString(languageKey) ?? 'en';
  }

  // User type (client or handyman)
  Future<void> setUserType(String userType) async {
    await _prefs.setString(userTypeKey, userType);
  }

  String? getUserType() {
    return _prefs.getString(userTypeKey);
  }

  // Onboarding status
  Future<void> setOnboardingCompleted(bool completed) async {
    await _prefs.setBool(onboardingKey, completed);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool(onboardingKey) ?? false;
  }

  // Secure storage for sensitive data
  Future<void> setAuthToken(String token) async {
    await _secureStorage.write(key: tokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: tokenKey);
  }

  Future<void> deleteAuthToken() async {
    await _secureStorage.delete(key: tokenKey);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString(userKey, jsonEncode(userData));
  }

  Map<String, dynamic>? getUserData() {
    final userJson = _prefs.getString(userKey);
    if (userJson == null) return null;
    return jsonDecode(userJson) as Map<String, dynamic>;
  }

  Future<void> clearUserData() async {
    await _prefs.remove(userKey);
    await _secureStorage.delete(key: tokenKey);
  }

  // Clear all data (for logout)
  Future<void> clearAll() async {
    await _prefs.clear();
    await _secureStorage.deleteAll();
  }
}
