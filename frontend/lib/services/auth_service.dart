import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final RxString _token = ''.obs;
  final RxInt _userId = RxInt(0);

  String? get token => _token.value.isEmpty ? null : _token.value;
  int get userId => _userId.value;

  @override
  void onInit() async {
    super.onInit();
    _token.value = await _storage.read(key: 'jwt') ?? '';
    final storedId = await _storage.read(key: 'userId');
    if (storedId != null) {
      _userId.value = int.tryParse(storedId) ?? 0;
    }
  }

  Future<void> saveToken(String newToken, String role, int id) async {
    _token.value = newToken;
    _userId.value = id;

    await _storage.write(key: 'jwt', value: newToken);
    await _storage.write(key: 'role', value: role);
    await _storage.write(key: 'userId', value: id.toString());
  }

  Future<void> clearToken() async {
    _token.value = '';
    _userId.value = 0;
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'role');
    await _storage.delete(key: 'userId');
  }
}
