import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:odyssey_app/services/auth_service.dart';

class ApiService extends GetxService {
  late final Dio _dio;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8081/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
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

        if (error.response?.statusCode == 401) {
          _authService.clearToken();
        }

        handler.next(error);
      },
    ));
  }

  Future<Response> login(String email, String password) async {
    try {
      return await _dio.post('/auth/SignIn', data: {
        'email': email,
        'password': password,
      });
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
    required String confirmPassword,
    required String userType,
  }) async {
    try {
      return await _dio.post('/auth/signup', data: {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
        'confirmPassword': confirmPassword,
        'userType': userType,
      });
    } on DioException catch (e) {
      print('Signup error: ${e.message}');
      print('Error response: ${e.response?.data}');
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
}
