import 'package:flutter/material.dart'; //Core Flutter UI package, used for Material Design widgets like Scaffold, ThemeData, etc.
import 'package:get/get.dart';//Imports the GetX package, which is used for state management, routing, and dependency injection.
import 'package:odyssey_app/screens/splash_screen.dart';//Imports the SplashScreen widget that shows up first when the app starts.
import 'bindings/bindings.dart'; //Imports your bindings, where dependencies are initialized using GetX.

//The entry point of the app.
//Calls runApp() and passes an instance of MyApp, which is the root widget of your application.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(//It's like MaterialApp, but enhanced with GetX features like easy routing, state management, and dependency injection.
      debugShowCheckedModeBanner: false,//Hides the debug banner from the top right corner in debug mode.
      home: SplashScreen(), // Direct widget reference
      initialBinding: AppBindings(),//This is how GetX handles dependency injection.
                                    //AppBindings() is a class where controllers, services, or other dependencies are registered using Get.put() or Get.lazyPut().
      theme: ThemeData(primarySwatch: Colors.blue),//Sets a global Material Design theme for the app.
    );
  }
}

// 1. Class (Encapsulation)
//class MyApp extends StatelessWidget
//➡️Encapsulation Example: All the widget UI code is hidden inside the MyApp class, and accessed only via its public interface (build() method).

//2.Inheritance
//MyApp inherits from StatelessWidget, a Flutter framework class.

//Inheritance allows MyApp to use properties and methods from StatelessWidget.

//➡️ This means your class gets access to the build() method and context handling.

// 3. Abstraction
//Flutter widgets like StatelessWidget, GetMaterialApp, and ThemeData are abstracted for you.

//You don’t need to know how GetMaterialApp works under the hood — you just use its public API (like home, theme, etc.).

//➡️ Abstraction hides complexity and shows only the necessary details.

//4. Polymorphism
//➡️ Dart uses runtime polymorphism to determine the actual type (GetMaterialApp) at runtime.

//How GetX Uses OOP//

/*AppBindings() is likely a class that extends Bindings and overrides the dependencies() method — a clear example of inheritance and method overriding.

Inside that, you probably use Get.put() or Get.lazyPut() to inject instances (objects) of controllers or services — again, core OOP.*/

/*OOP Concept	Where It's Used
Class           	MyApp, SplashScreen, AppBindings
Encapsulation   	Code hidden inside classes like MyApp
Inheritance	      MyApp extends StatelessWidget
Abstraction	      Using widgets like GetMaterialApp without knowing internal code
Polymorphism	    Returning different widget types (like GetMaterialApp) from build()*/