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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ThingsToDoPage(),
    );
  }
}

class ThingsToDoPage extends StatelessWidget {
  const ThingsToDoPage({super.key});

  final List<Map<String, dynamic>> activities = const [
    {
      'image': 'assets/logo.jpeg',
      'title': "Private Tour of Jaipur's Most Instagrammable Spots",
      'price': '\$329',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Architectural Tour in Rome",
      'price': '\$419',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Exotic Ice Cream Tasting",
      'price': '\$329',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Train Ride Across Nine Arches Bridge",
      'price': '\$1219',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Desert Safari in Dubai",
      'price': '\$799',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Snorkeling Adventure in Bali",
      'price': '\$499',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Vintage Car Tour in Havana",
      'price': '\$399',
    },
    {
      'image': 'assets/logo.jpeg',
      'title': "Northern Lights Watching in Iceland",
      'price': '\$999',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Things To Do',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 15),
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          SizedBox(width: 15),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: activities.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return ActivityCard(
                    image: activity['image']!,
                    title: activity['title']!,
                    price: activity['price']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Sort"),
                _buildButton("Filter"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: () {},
        child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const ActivityCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(image, height: 120, width: double.infinity, fit: BoxFit.cover),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Icon(Icons.favorite_border, color: Colors.black),
          ],
        ),
      ],
    );
  }
}





// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const ThingsToDoPage(),
//     );
//   }
// }
//
// class ThingsToDoPage extends StatelessWidget {
//   const ThingsToDoPage({super.key});
//
//   final List<Map<String, dynamic>> activities = const [
//     {
//       'image': 'assets/jaipur.jpg',
//       'title': "Private Tour of Jaipur's Most Instagrammable Spots",
//       'price': '\$329',
//     },
//     {
//       'image': 'assets/rome.jpg',
//       'title': "Architectural Tour in Rome",
//       'price': '\$419',
//     },
//     {
//       'image': 'assets/icecream.jpg',
//       'title': "Exotic Ice Cream Tasting",
//       'price': '\$329',
//     },
//     {
//       'image': 'assets/train.jpg',
//       'title': "Train Ride Across Nine Arches Bridge",
//       'price': '\$1219',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text(
//           'Things To Do',
//           style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//         actions: const [
//           Icon(Icons.favorite_border, color: Colors.black),
//           SizedBox(width: 15),
//           Icon(Icons.shopping_bag_outlined, color: Colors.black),
//           SizedBox(width: 15),
//           Icon(Icons.search, color: Colors.black),
//           SizedBox(width: 16),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 itemCount: activities.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   final activity = activities[index];
//                   return ActivityCard(
//                     image: activity['image']!,
//                     title: activity['title']!,
//                     price: activity['price']!,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildButton("Sort"),
//                 _buildButton("Filter"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildButton(String text) {
//     return SizedBox(
//       width: 150,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: const BorderSide(color: Colors.black),
//           ),
//         ),
//         onPressed: () {},
//         child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 16)),
//       ),
//     );
//   }
// }
//
// class ActivityCard extends StatelessWidget {
//   final String image;
//   final String title;
//   final String price;
//
//   const ActivityCard({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.price,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.asset(image, height: 120, width: double.infinity, fit: BoxFit.cover),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             const Icon(Icons.favorite_border, color: Colors.black),
//           ],
//         ),
//       ],
//     );
//   }
// }
