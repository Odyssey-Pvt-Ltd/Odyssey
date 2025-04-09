import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'bindings/bindings.dart';
import 'services/auth_provider.dart'; // ✅ This is the correct path
import 'screens/splash_screen.dart'; // ✅ Make sure SplashScreen exists here

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Provide AuthProvider globally
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: AppBindings(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
