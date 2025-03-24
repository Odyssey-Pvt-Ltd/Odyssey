import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odyssey_app/screens/auth_provider.dart';
import 'package:odyssey_app/screens/booking_screen1.dart';
import 'package:odyssey_app/screens/vehicle_booking_screen2.dart';
import 'package:odyssey_app/SignUpScreen.dart';
import 'package:odyssey_app/screens/splash_screen.dart';
import 'package:odyssey_app/screens/LoginScreen.dart';
import 'package:odyssey_app/screens/signup_password_screen.dart';
import 'package:odyssey_app/screens/onboarding_screen.dart';
import 'package:odyssey_app/screens/location_access_screen.dart';
import 'package:odyssey_app/screens/preferences_screen.dart';
import 'package:odyssey_app/screens/explore_screen.dart';
import 'package:odyssey_app/screens/manual_planner_screen1.dart';
import 'package:odyssey_app/screens/chat_bot.dart';
import 'package:odyssey_app/notes.dart';
import 'package:odyssey_app/plan_a_trip.dart';
import 'package:odyssey_app/screens/things_to_do.dart';
import 'package:odyssey_app/screens/vehical_booking_screen1.dart';
import 'package:odyssey_app/screens/places.dart';
import 'package:odyssey_app/screens/home_screen1.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      // Add AuthProvider to the provider list
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: OdysseyApp(),
  ),
);

class OdysseyApp extends StatelessWidget {
  const OdysseyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/signup_password': (context) => PasswordSetupScreen(
          name: '',
          email: '',
          phone: '',
        ),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/preferences': (context) => PreferencesScreen(),
        '/location': (context) => LocationAccessScreen(),
        '/explore': (context) => ExploreScreen(),
        '/manual_planner': (context) => ManualPlannerPage(),
        '/chat': (context) => ChatScreen(),
        '/notes': (context) => NotesScreen(),
        '/plan_trip': (context) => PlanTripScreen(),
        '/things_to_do': (context) => ThingsToDoPage(),
        '/vehicle_booking': (context) => VehicleBookingScreen(),
        '/vehicle_detail': (context) => VehicleDetailScreen(),
        '/hotel_details': (context) => HotelDetailsScreen(),
        '/places': (context) => PlacesScreen(),
      },
    );
  }
}