import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../controllers/auth_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}