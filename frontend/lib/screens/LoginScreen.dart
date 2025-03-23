import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_services.dart';
import 'auth_provider.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login(BuildContext context) async {
    try {
      final response = await _apiService.login(
        _emailController.text,
        _passwordController.text,
      );
      // Save JWT token using AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.saveJwt(response['jwt']);
      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _emailController, decoration: InputDecoration(hintText: 'Email')),
          TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(hintText: 'Password')),
          ElevatedButton(
            onPressed: () => _login(context),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}