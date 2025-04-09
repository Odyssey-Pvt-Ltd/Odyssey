import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:odyssey_app/screens/LoginScreen.dart';
import 'package:odyssey_app/screens/home_screen1.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final ApiService _api = Get.find();
  final AuthService _auth = Get.find();
  final RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _api.login(email, password);
      await _auth.saveToken(
        response.data['jwt'],
        response.data['role'],
        response.data['id'], // or response.data['user']['id'] depending on your backend
      );

      Get.to(() => HomeScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    required String confirmPassword,
    required String userType,
  }) async {
    try {
      isLoading.value = true;

      final response = await _api.signUp(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        password: password,
        confirmPassword: confirmPassword,
        userType: userType,
      );

      final data = response.data;
      await _auth.saveToken(
        response.data['jwt'],
        response.data['role'],
        response.data['id'], // or response.data['user']['id'] depending on your backend
      );

      Get.offAll(() => HomeScreen());
      Get.snackbar('Success', 'Account created successfully!');
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      Get.snackbar('Signup Error', message.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
