import 'package:dio/dio.dart';
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
}