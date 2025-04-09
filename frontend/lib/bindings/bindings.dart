import 'package:get/get.dart';
import '../services/api_service.dart';//likely handles API calls (like GET, POST requests).
import '../services/auth_service.dart';//probably takes care of login, logout, and user sessions.
import '../controllers/auth_controller.dart';//manages UI logic and interacts with the above services.

//This defines a class called AppBindings
//It implements the Bindings interface from GetX. That means it must define the method dependencies().
class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
/*Why Use Bindings?
You centralize all your dependency injection logic.

Your widgets/controllers/services are created efficiently.

It avoids tight coupling, and makes testing/debugging easier.
*/

/*OOP Concept	How It's Used Here
Encapsulation	 Services/controllers encapsulate logic
Abstraction	   You only care about what the class does, not how
Interfaces	   Bindings is an interface, and AppBindings implements it
Lazy
Initialization Efficient object creation at runtime*/