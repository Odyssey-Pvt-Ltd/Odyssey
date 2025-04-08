import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:odyssey_app/services/auth_service.dart';

class ApiService extends GetxService {
  late final Dio _dio;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();

    // Configure Dio with base options
    _dio = Dio(BaseOptions(
      // Use 10.0.2.2 for Android emulator, 127.0.0.1 for iOS simulator
      baseUrl: 'http://10.0.2.2:8081/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final token = _authService.token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print('Sending request to ${options.uri}');
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        print('API Error: ${error.message}');
        print('Response: ${error.response?.data}');

        // Handle 401 Unauthorized errors
        if (error.response?.statusCode == 401) {
          _authService.clearToken();
          // You might want to navigate to login screen here
        }

        handler.next(error);
      },
    ));
  }

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/SignIn',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response;
    } on DioException catch (e) {
      print('Login error: ${e.message}');
      rethrow;
    }
  }

  Future<Response> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    required String userType,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/signup',
        data: {
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'address': address,
          'password': password,
          'userType': userType,
          'confirmPassword': password, // Assuming your backend expects this
        },
      );

      return response;
    } on DioException catch (e) {
      print('Signup error: ${e.message}');
      if (e.response != null) {
        print('Error response data: ${e.response?.data}');
      }
      rethrow;
    }
  }

  Future<Response> getUserProfile() async {
    try {
      return await _dio.get('/user/profile');
    } on DioException catch (e) {
      print('Get profile error: ${e.message}');
      rethrow;
    }
  }

// Add other API methods as needed
}