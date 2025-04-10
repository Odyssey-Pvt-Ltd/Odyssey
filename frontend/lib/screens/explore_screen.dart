import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  final List<Map<String, String>> listings = const [
    {
      'title': 'Mirissa Beach Vibe',
      'location': 'Mirissa, Sri Lanka',
      'price': '\$40',
      'image': 'assets/mirissa.jpg'
    },
    {
      'title': 'Luxury Stay in Galle Fort',
      'location': 'Galle, Southern Province',
      'price': '\$60',
      'image': 'assets/logo.jpeg'
    },
    {
      'title': 'Ella Rock Hike Adventure',
      'location': 'Ella, Uva Province',
      'price': '\$35',
      'image': 'assets/mirissa.jpg'
    },
    {
      'title': 'Kandy Cultural Tour',
      'location': 'Kandy, Central Province',
      'price': '\$45',
      'image': 'assets/logo.jpeg'
    },
    {
      'title': 'Whale Watching in Mirissa',
      'location': 'Mirissa, Southern Coast',
      'price': '\$55',
      'image': 'assets/mirissa.jpg'
    },
    {
      'title': 'Colombo City Street Food Tour',
      'location': 'Colombo, Western Province',
      'price': '\$30',
      'image': 'assets/logo.jpeg'
    },
    {
      'title': 'Tea Plantation Visit',
      'location': 'Nuwara Eliya, Hill Country',
      'price': '\$28',
      'image': 'assets/mirissa.jpg'
    },
    {
      'title': 'Scenic Train Ride to Ella',
      'location': 'Kandy → Ella',
      'price': '\$25',
      'image': 'assets/logo.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Image.asset('assets/logo.jpeg', height: 45),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Suggestions",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: listings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final item = listings[index];
                  return _buildListingCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard(Map<String, String> listing) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              listing['image']!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  listing['location']!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  listing['price']!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
