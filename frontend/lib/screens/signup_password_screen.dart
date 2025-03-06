import 'package:flutter/material.dart';
import 'package:odyssey_app/screens/onboarding_screen.dart';

class PasswordSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Back Button
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
              ),
            ),
          ),
          // Content Container
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Column(
                    children: [
                      Text(
                        'Set up a password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      // Password Fields
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Security question 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Security question 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                  // Finish Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // After successful signup, navigate to onboarding
                      Navigator.pushReplacementNamed(context, '/onboarding');
                    },
                    child: Center(
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
