import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _jwt;

  String? get jwt => _jwt;

  // Save JWT token to SharedPreferences
  Future<void> saveJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', jwt);
    _jwt = jwt;
    notifyListeners();
  }

  // Load JWT token from SharedPreferences
  Future<void> loadJwt() async {
    final prefs = await SharedPreferences.getInstance();
    _jwt = prefs.getString('jwt');
    notifyListeners();
  }

  // Clear JWT token (for logout)
  Future<void> clearJwt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    _jwt = null;
    notifyListeners();
  }
}