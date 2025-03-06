import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_password_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/location_access_screen.dart';
import 'screens/sl_map_screen.dart';
import 'screens/explore_screen.dart';

void main() => runApp(OdysseyApp());

class OdysseyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/signup_password': (context) => PasswordSetupScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/location': (context) => LocationAccessScreen(),
        '/map_screen': (context) => OnboardingScreen2(),
        '/explore' : (context) => ExploreScreen(),
      },
    );
  }
}
