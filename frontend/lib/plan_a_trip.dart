import 'package:flutter/material.dart';
import 'package:odyssey_app/screens/chat_bot.dart';
import 'package:odyssey_app/screens/manual_planner_screen1.dart';



class PlanTripScreen extends StatelessWidget {
  const PlanTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Plan a Trip"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PageView(
                children: [
                  travelImage('https://source.unsplash.com/800x600/?train,bridge'),
                  travelImage('https://source.unsplash.com/800x600/?city,architecture'),
                  travelImage('https://source.unsplash.com/800x600/?mountains,travel'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "How would you like to plan your journey?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            actionButton(context, "Plan Manually", ManualPlannerPage()),
            const SizedBox(height: 12),
            actionButton(context, "Automatic", ChatScreen()),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Tip: You can personalize your journey more by selecting the manual planner.",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget travelImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget actionButton(BuildContext context, String title, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }
}
