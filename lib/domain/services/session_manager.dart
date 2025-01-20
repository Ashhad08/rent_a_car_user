import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/auth/login_model.dart';

class SessionManager {
  final String _isLoggedInKey = 'user';
  final String _isGuest = 'isGuest';

  Future<void> setLoggedIn(LoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_isLoggedInKey, loginModelToJson(user));
  }

  Future<void> setUserIsAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isGuest, true);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return ((prefs.getString(_isLoggedInKey))?.isNotEmpty ?? false) ||
        (prefs.getBool(_isGuest) ?? false);
  }

  Future<LoginModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(_isLoggedInKey);
    if (user == null) {
      return null;
    } else {
      return LoginModel.fromJson(jsonDecode(user));
    }
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_isGuest);
  }
}
