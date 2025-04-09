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
        print('➡️ Sending request to ${options.uri}');
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        print('❌ API Error: ${error.message}');
        print('Response: ${error.response?.data}');
        if (error.response?.statusCode == 401) {
          _authService.clearToken();
        }
        handler.next(error);
      },
    ));
  }

  // LOGIN
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

  // SIGNUP
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
      rethrow;
    }
  }

  // GET USER PROFILE
  Future<Response> getUserProfile() async {
    try {
      return await _dio.get('/user/profile');
    } on DioException catch (e) {
      print('Get profile error: ${e.message}');
      rethrow;
    }
  }

  // CREATE SHOP
  Future<Response> createShop({
    required int userId,
    required String shopName,
    required String description,
    required String street,
    required String city,
    required String phoneNumber,
  }) async {
    try {
      return await _dio.put('/admin/shop', data: {
        'userId': userId,
        'shopName': shopName,
        'description': description,
        'address': {
          'street': street,
          'city': city,
        },
        'phoneNumber': phoneNumber,
        'images': [],
      });
    } on DioException catch (e) {
      print('Create shop error: ${e.message}');
      rethrow;
    }
  }

  // GET VENDOR'S SHOP (if exists)
  Future<Response> getMyShop() async {
    try {
      final response = await _dio.get('/shop');
      final List<dynamic> shops = response.data;

      final userId = _authService.userId;
      final userShop = shops.firstWhere(
            (shop) => shop['user']['id'] == userId,
        orElse: () => null,
      );

      if (userShop != null) {
        return Response(
          requestOptions: response.requestOptions,
          data: userShop,
          statusCode: 200,
        );
      } else {
        throw Exception('No shop found for this user');
      }
    } catch (e) {
      print('Get shop error: $e');
      rethrow;
    }
  }
}
