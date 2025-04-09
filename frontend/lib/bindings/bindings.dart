import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../controllers/auth_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    // Load AuthService and initialize JWT
    await Get.putAsync<AuthService>(() async {
      final authService = AuthService();
      await authService.init();
      return authService;
    });


    Get.put(ApiService());

    Get.lazyPut(() => AuthController(), fenix: true);
  }
}