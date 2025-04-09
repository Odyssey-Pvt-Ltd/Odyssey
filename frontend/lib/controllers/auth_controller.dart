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
      await _auth.saveToken(response.data['jwt'],response.data['role']);
      Get.to(()=>HomeScreen());
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
        userType: userType,
      );
      if(response.statusCode==200){
        Get.to(()=>LoginScreen());
        Get.snackbar('Success', 'Account created successfully!');
      }else{
        response.data['message'];
      }

    } catch (e) {
      Get.snackbar('Error', e.  toString());
    } finally {
      isLoading.value = false;
    }
  }
}
/* Import Dio for making HTTP requests
import 'package:dio/dio.dart';

// Import GetX (hiding Dio's Response to avoid conflict with Flutter Response)
import 'package:get/get.dart' hide Response;

// Import AuthService to access stored JWT tokens
import 'auth_service.dart';

// ApiService class extends GetxService, making it injectable and persistent in the app
class ApiService extends GetxService {
  // Late-initialized Dio instance used for all API calls
  late final Dio _dio;

  // Lifecycle method called when the service is initialized
  @override
  void onInit() {
    super.onInit();

    // Initialize Dio with base URL and default headers
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8081/api', // Base URL for all API requests
      headers: {'Content-Type': 'application/json'}, // Set request content type to JSON
    ));

    // Add an interceptor to automatically attach JWT token to each request
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get the token from AuthService
        final token = Get.find<AuthService>().token;

        // If token exists, add it to request headers
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // Proceed with the request
        handler.next(options);
      },
    ));
  }

  // Optional: Getter to expose Dio instance for API calls elsewhere
  Dio get client => _dio;
}*/
