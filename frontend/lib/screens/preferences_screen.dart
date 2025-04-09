import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Map to store the selection state of preferences
  Map<String, bool> preferences = {
    'Adventure': false,
    'Beach': false,
    'City Tours': false,
    'Hiking': false,
    'Cultural': false,
    'Food & Drink': false,
    'Nature': false,
    'Shopping': false,
    'Sightseeing': false,
    'Nightlife': false,
    'Relaxation': false,
    'Sports': false,
    'Historical': false,
    'Art & Museums': false,
    'Family Friendly': false,
    'Romantic': false,
    'Luxury': false,
    'Budget': false,
    'Solo Travel': false,
    'Group Travel': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
            ),
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Add your preferences',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Preferences Grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: preferences.keys.map((label) {
                    return _buildPreferenceChip(label);
                  }).toList(),
                ),
              ),
            ),
            // Bottom Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () {

                      // Navigate to HomeScreen
                      Navigator.pushReplacementNamed(context, '/home');

                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Next Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,

                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {

                      // Navigate to HomeScreen
                      Navigator.pushReplacementNamed(context, '/home');

                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceChip(String label) {
    bool isSelected = preferences[label]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          preferences[label] = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}