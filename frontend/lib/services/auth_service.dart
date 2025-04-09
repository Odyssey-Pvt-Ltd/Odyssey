import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final RxString _token = ''.obs;

  String? get token => _token.value.isEmpty ? null : _token.value;

  Future<void> init() async {
    _token.value = await _storage.read(key: 'jwt') ?? '';
  }

  Future<void> saveToken(String newToken, String role) async {
    _token.value = newToken;
    await _storage.write(key: 'jwt', value: newToken);
    await _storage.write(key: 'role', value: role);
  }

  Future<void> clearToken() async {
    _token.value = '';
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'role');
  }
}