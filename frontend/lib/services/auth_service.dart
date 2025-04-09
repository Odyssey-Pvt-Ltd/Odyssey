// Import Flutter secure storage for safely storing sensitive data like tokens
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Import GetX to use reactive variables and service injection
import 'package:get/get.dart';

// AuthService handles secure storage and management of the auth token
class AuthService extends GetxService {
  // Initialize secure storage (encrypts values on device)
  final _storage = const FlutterSecureStorage();

  // Reactive variable to hold the JWT token in memory
  final RxString _token = ''.obs;

  // Getter to safely access the token
  // Returns null if the token string is empty
  String? get token => _token.value.isEmpty ? null : _token.value;

  // Called automatically when the service is initialized
  @override
  void onInit() async {
    super.onInit();

    // Read the saved token from secure storage (if available)
    // If no token is found, use an empty string
    _token.value = await _storage.read(key: 'jwt') ?? '';
  }

  // Method to save a new token and user role securely
  Future<void> saveToken(String newToken, String role) async {
    // Update the in-memory reactive token
    _token.value = newToken;

    // Persist the token and role securely on the device
    await _storage.write(key: 'jwt', value: newToken);
    await _storage.write(key: 'role', value: role);
  }

  // Method to clear the stored token and role (e.g. during logout)
  Future<void> clearToken() async {
    // Clear the in-memory token
    _token.value = '';

    // Delete the stored token and role from secure storage
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'role');
  }
}


/*import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final RxString _token = ''.obs;

  String? get token => _token.value.isEmpty ? null : _token.value;

  @override
  void onInit() async {
    super.onInit();
    _token.value = await _storage.read(key: 'jwt') ?? '';
  }

  Future<void> saveToken(String newToken,String role) async {
    _token.value = newToken;
    await _storage.write(key: 'jwt', value: newToken);
    await _storage.write(key: 'role', value: role);
  }

  Future<void> clearToken() async {
    _token.value = '';
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'role');
  }
}*/