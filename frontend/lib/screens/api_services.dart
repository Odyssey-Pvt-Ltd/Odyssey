import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8081"; // Replace with your backend URL

  // Sign-in method
  Future<Map<String, dynamic>> login(String email, String password) async {
    final body = jsonEncode({'email': email, 'password': password});
    print('Sending request body: $body'); // Log the request body

    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/SignIn'), // Replace with your sign-in endpoint
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response status: ${response.statusCode}'); // Log the response status
    print('Response body: ${response.body}'); // Log the response body

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse the response JSON
    } else {
      throw Exception('Failed to login');
    }
  }

  // Add this method to fetch user profile
  Future<Map<String, dynamic>> fetchUserProfile(String jwt) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/user/profile'), // Replace with your profile endpoint
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse the response JSON
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  getUserProfile(String jwt) {}

}