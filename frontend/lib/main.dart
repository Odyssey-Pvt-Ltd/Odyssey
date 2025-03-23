import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth_provider.dart';
import 'screens/LoginScreen.dart';
import 'home_screen1.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: MyApp(),
          ),
      );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            // Check if the user is logged in (JWT exists)
            if (authProvider.jwt == null) {
              return LoginScreen(); // Show login screen if not logged in
            } else {
              return HomeScreen(); // Show home screen if logged in
            }
          },
        ),
        routes: {
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),

    },
    );
  }
}