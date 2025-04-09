import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _jwt;
  String? _role;

  String? get jwt => _jwt;
  String? get role => _role;

  Future<void> saveJwt(String jwt, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', jwt);
    await prefs.setString('role', role);
    _jwt = jwt;
    _role = role;
    notifyListeners();
  }

  Future<void> loadJwt() async {
    final prefs = await SharedPreferences.getInstance();
    _jwt = prefs.getString('jwt');
    _role = prefs.getString('role');
    notifyListeners();
  }

  Future<void> clearJwt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('role');
    _jwt = null;
    _role = null;
    notifyListeners();
  }

  // ✅ THIS IS THE ONE YOU NEED
  bool get isLoggedIn => _jwt != null && _jwt!.isNotEmpty;
}
