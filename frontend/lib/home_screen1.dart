import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth_provider.dart';
import 'screens/api_services.dart';

class HomeScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authProvider.clearJwt(); // Clear JWT token on logout
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: _apiService.getUserProfile(authProvider.jwt!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final user = snapshot.data!;
                return Column(
                  children: [
                    Text('Name: ${user['name']}'),
                    Text('Email: ${user['email']}'),
                  ],
                );
              }
            },
            ),
        );
    }
}