import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class LocalStorageService {
  late final SharedPreferences _prefs;
  late final Box _secureBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _secureBox = await Hive.openBox('secureBox');
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _secureBox.put(AppConstants.keyAccessToken, accessToken);
    await _secureBox.put(AppConstants.keyRefreshToken, refreshToken);
  }

  String? get accessToken => _secureBox.get(AppConstants.keyAccessToken) as String?;
  String? get refreshToken => _secureBox.get(AppConstants.keyRefreshToken) as String?;

  Future<void> clearTokens() async {
    await _secureBox.delete(AppConstants.keyAccessToken);
    await _secureBox.delete(AppConstants.keyRefreshToken);
  }

  Future<void> saveSchoolId(String schoolId) async {
    await _prefs.setString(AppConstants.keySchoolId, schoolId);
  }

  String? getSchoolId() => _prefs.getString(AppConstants.keySchoolId);

  Future<void> saveCurrentUserJson(Map<String, dynamic> json) async {
    await _prefs.setString(AppConstants.keyCurrentUser, jsonEncode(json));
  }

  Map<String, dynamic>? getCurrentUserJson() {
    final raw = _prefs.getString(AppConstants.keyCurrentUser);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clearAll() async {
    await _secureBox.clear();
    await _prefs.clear();
  }
}
