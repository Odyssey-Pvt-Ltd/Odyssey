import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odyssey_app/screens/LoginScreen.dart';
import 'SignUpScreen.dart';
import 'home_screen1.dart';
import 'screens/auth_provider.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odyssey App',
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home_screen1': (context) => HomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
      },
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.jwt == null
              ? const LoginScreen()
              : HomeScreen();
        },
      ),
    );
  }
}
