import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:odyssey_app/screens/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Add a delay before navigating to LoginScreen
    Future.delayed(Duration(seconds: 3), () {
      Get.to(()=>LoginScreen());
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.jpeg',
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}
