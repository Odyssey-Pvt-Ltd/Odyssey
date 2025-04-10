import 'package:flutter/material.dart';

class ManualPlannerPage extends StatelessWidget {
  ManualPlannerPage({super.key});

  final List<Map<String, String>> rideOptions = [
    {'image': 'https://via.placeholder.com/150/FF5733', 'label': 'Car'},
    {'image': 'https://via.placeholder.com/150/33FF57', 'label': 'Train'},
    {'image': 'https://via.placeholder.com/150/3357FF', 'label': 'Bike'},
    {'image': 'https://via.placeholder.com/150/FFD700', 'label': 'Bus'},
  ];

  final List<Map<String, String>> itemOptions = [
    {'image': 'https://via.placeholder.com/150/00BFFF', 'label': 'Camera'},
    {'image': 'https://via.placeholder.com/150/DC143C', 'label': 'Shoes'},
    {'image': 'https://via.placeholder.com/150/32CD32', 'label': 'Map'},
    {'image': 'https://via.placeholder.com/150/FF8C00', 'label': 'Snacks'},
  ];

  final String hotelImage = 'https://via.placeholder.com/300x150/C0C0C0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Manual Planner',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
            sectionTitle("Rides"),
            gridList(rideOptions),
            const SizedBox(height: 20),
            sectionTitle("Hotels"),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(hotelImage, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            sectionTitle("Items"),
            gridList(itemOptions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Trip plan saved!")),
          );
        },
        label: const Text("Save Plan"),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget gridList(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(item['image']!, fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item['label']!,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
