import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intime_manager/models/response/login_response.dart';

class PreferenceService {
  static const String _keySkipWelcome = 'skip_welcome';
  static const String _keyLoginResponse = 'login_response';

  static Future<bool> shouldSkipWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySkipWelcome) ?? false;
  }

  static Future<void> setSkipWelcome(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySkipWelcome, value);
  }

  static Future<LoginResponse?> getLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyLoginResponse);
    if (jsonString == null) {
      return null;
    }
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return LoginResponse.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveLoginResponse(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(loginResponse.toJson());
    await prefs.setString(_keyLoginResponse, jsonString);
  }

  static Future<void> clearLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoginResponse);
  }

  static Future<bool> hasLoginInfo() async {
    final loginResponse = await getLoginResponse();
    return loginResponse != null &&
        loginResponse.corporations.isNotEmpty;
  }
}
