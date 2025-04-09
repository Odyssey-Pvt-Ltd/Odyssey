import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8081";

  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/SignIn'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Login failed');
    }
  }

  // SIGN UP
  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    required String confirmPassword,
    required String userType,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
        'confirmPassword': confirmPassword,
        'userType': userType,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Signup failed');
    }
  }

  // GET USER PROFILE
  Future<Map<String, dynamic>> fetchUserProfile(String jwt) async {
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

  // GET ALL SHOPS (to find current vendor's shop)
  Future<List<dynamic>> fetchAllShops(String jwt) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/shop'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception('Failed to fetch shop list');
    }
  }

  // CREATE SHOP (PUT)
  Future<void> createShop({
    required String jwt,
    required int userId,
    required String shopName,
    required String description,
    required String street,
    required String city,
    required String phoneNumber,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/admin/shop'),
      headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "userId": userId,
        "shopName": shopName,
        "description": description,
        "address": {
          "street": street,
          "city": city,
        },
        "phoneNumber": phoneNumber,
        "images": [],
      }),
    );

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to create shop');
    }
  }
}
