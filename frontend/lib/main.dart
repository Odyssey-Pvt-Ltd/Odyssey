import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odyssey_app/screens/auth_provider.dart';
import 'package:provider/provider.dart';

import 'bindings/bindings.dart';
import 'screens/splash_screen.dart';
import 'services/auth_provider.dart'; // <-- Make sure this path is correct

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // ✅ Provide your AuthProvider here
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
      home: SplashScreen(),
      initialBinding: AppBindings(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
