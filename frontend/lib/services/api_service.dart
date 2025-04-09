// Import Dio for making HTTP requests
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
}


/*import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'auth_service.dart';

class ApiService extends GetxService {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8081/api',
      headers: {'Content-Type': 'application/json'},
    ));

    // Add interceptors for auth tokens
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = Get.find<AuthService>().token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  Future<Response> login(String email, String password) async {
    return _dio.post('/auth/SignIn', data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    required String userType,
  }) async {
    return _dio.post('/auth/signup', data: {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
      'userType': userType,
    });
  }
}*/