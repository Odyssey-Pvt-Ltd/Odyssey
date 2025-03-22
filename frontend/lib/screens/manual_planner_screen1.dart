import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManualPlannerPage(),
    );
  }
}

class ManualPlannerPage extends StatelessWidget {
  final List<String> rideImages = [
    'https://via.placeholder.com/150/FF5733',
    'https://via.placeholder.com/150/33FF57',
    'https://via.placeholder.com/150/3357FF',
    'https://via.placeholder.com/150/FFD700',
  ];

  final List<String> itemImages = [
    'https://via.placeholder.com/150/00BFFF',
    'https://via.placeholder.com/150/DC143C',
    'https://via.placeholder.com/150/32CD32',
    'https://via.placeholder.com/150/FF8C00',
  ];

  final String hotelImage = 'https://via.placeholder.com/300x150/C0C0C0';

  ManualPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Manual Planner',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rides",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.5,
              ),
              itemCount: rideImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(rideImages[index], fit: BoxFit.cover),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Hotels",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(hotelImage, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            const Text(
              "Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.5,
              ),
              itemCount: itemImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(itemImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}






