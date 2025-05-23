import 'package:flutter/material.dart';
import 'api_services.dart';

class ProfileScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final String jwt;

  ProfileScreen({required this.jwt});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _apiService.getUserProfile(jwt),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
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
    );
  }
}