import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8081"; // Replace with your backend URL

  // Example: User Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/SignIn'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Example: Fetch User Profile
  Future<Map<String, dynamic>> getUserProfile(String jwt) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/user/profile'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

// Add more methods for other endpoints (e.g., signup, fetch listings, etc.)
}