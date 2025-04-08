import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odyssey_app/screens/splash_screen.dart';

import 'bindings/bindings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Direct widget reference
      initialBinding: AppBindings(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}