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
//       home: AutomaticPlannerPage(),
//     );
//   }
// }
//
// class AutomaticPlannerPage extends StatelessWidget {
//   const AutomaticPlannerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text(
//           'Automatic Planner',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Icon(Icons.circle, size: 10, color: Colors.black),
//                     Container(
//                       width: 2,
//                       height: 40,
//                       color: Colors.black,
//                     ),
//                     Icon(Icons.location_pin, color: Colors.black),
//                   ],
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           hintText: "Starting location",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         decoration: InputDecoration(
//                           hintText: "Destination",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.grey[300],
//                 ),
//                 child: const Center(
//                   child: Icon(Icons.map, size: 100, color: Colors.black54),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 10,
//               width: double.infinity,
//               color: Colors.black26,
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 10,
//               width: 150,
//               color: Colors.black26,
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   "Start",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         )
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black38,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.map), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
//         ],
//       ),
//     );
//   }
// }
