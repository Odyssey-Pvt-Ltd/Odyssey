// Import GetX for controller, routing, state management
import 'package:get/get.dart';

// Import screens used for navigation
import 'package:odyssey_app/screens/LoginScreen.dart';
import 'package:odyssey_app/screens/home_screen1.dart';

// Import services to handle API and authentication logic
import '../services/api_service.dart';
import '../services/auth_service.dart';

// Define the AuthController which extends GetxController
class AuthController extends GetxController {
  // Get the singleton instance of ApiService using GetX's dependency injection
  final ApiService _api = Get.find();

  // Get the singleton instance of AuthService
  final AuthService _auth = Get.find();

  // Reactive boolean to track loading state
  final RxBool isLoading = false.obs;

  // Method to handle user login
  Future<void> login(String email, String password) async {
    try {
      // Start loading
      isLoading.value = true;

      // Call the API to attempt login with provided email and password
      final response = await _api.login(email, password);

      // Save the received JWT token and role using AuthService
      await _auth.saveToken(response.data['jwt'], response.data['role']);

      // Navigate to the home screen upon successful login
      Get.to(() => HomeScreen());
    } catch (e) {
      // If an error occurs, show a snackbar with the error message
      Get.snackbar('Error', e.toString());
    } finally {
      // Stop loading regardless of success or error
      isLoading.value = false;
    }
  }

  // Method to handle user registration
  Future<void> signUp({
    required String name,          // User's name
    required String email,         // Email address
    required String phoneNumber,   // Phone number
    required String address,       // Address
    required String password,      // Password
    required String userType,      // Role or type of user
  }) async {
    try {
      // Start loading
      isLoading.value = true;

      // Send signup request with all user details
      final response = await _api.signUp(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        password: password,
        userType: userType,
      );

      // Check if sign-up was successful (HTTP 200 OK)
      if (response.statusCode == 200) {
        // Navigate to the login screen after successful registration
        Get.to(() => LoginScreen());

        // Show success message
        Get.snackbar('Success', 'Account created successfully!');
      } else {
        // ⚠️ This line currently does nothing — should display the error message
        // Correct usage might be: Get.snackbar('Error', response.data['message']);
        response.data['message'];
      }

    } catch (e) {
      // Show error message in a snackbar if an exception occurs
      Get.snackbar('Error', e.toString());
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }
}
