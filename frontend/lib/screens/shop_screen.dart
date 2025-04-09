import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  final Map<String, dynamic> shopData;

  const ShopScreen({Key? key, required this.shopData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final address = shopData['address'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Shop Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _infoTile("Shop Name", shopData['shopName']),
            _infoTile("Description", shopData['description']),
            _infoTile("City", address['city']),
            _infoTile("Street", address['street']),
            _infoTile("Phone", shopData['phoneNumber']),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Listing screen coming soon!")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text("Create Listing"),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
//
//
// class ShopScreen extends StatefulWidget {
//   final int userId;
//
//   const ShopScreen({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   State<ShopScreen> createState() => _ShopScreenState();
// }
//
// class _ShopScreenState extends State<ShopScreen> {
//   final ApiService _apiService = ApiService();
//   bool _isLoading = true;
//   Map<String, dynamic>? _shop;
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController shopNameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController streetController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchShop();
//   }
//
//   Future<void> fetchShop() async {
//     try {
//       final response = await _apiService.getMyShops();
//       final List shops = response.data;
//       if (shops.any((shop) => shop['user']['id'] == widget.userId)) {
//         setState(() {
//           _shop = shops.firstWhere((shop) => shop['user']['id'] == widget.userId);
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> createShop() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     try {
//       await _apiService.createShop(
//         userId: widget.userId,
//         shopName: shopNameController.text.trim(),
//         description: descriptionController.text.trim(),
//         street: streetController.text.trim(),
//         city: cityController.text.trim(),
//         phoneNumber: phoneController.text.trim(),
//       );
//       await fetchShop(); // Refresh
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to create shop")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Vendor Shop'), backgroundColor: Colors.black),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: _shop != null
//             ? _buildShopDetails(_shop!)
//             : _buildShopForm(),
//       ),
//     );
//   }
//
//   Widget _buildShopDetails(Map<String, dynamic> shop) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Your Shop", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 16),
//         _infoRow("Name", shop['shopName']),
//         _infoRow("Description", shop['description']),
//         _infoRow("City", shop['address']['city']),
//         _infoRow("Street", shop['address']['street']),
//         _infoRow("Phone", shop['phoneNumber']),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Listing screen coming soon!")),
//             );
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//           child: const Text("Create Listing"),
//         ),
//       ],
//     );
//   }
//
//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Row(
//         children: [
//           Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShopForm() {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         children: [
//           const Text("Create Your Shop", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 16),
//           _buildField(shopNameController, "Shop Name"),
//           _buildField(descriptionController, "Description"),
//           _buildField(streetController, "Street"),
//           _buildField(cityController, "City"),
//           _buildField(phoneController, "Phone Number"),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: createShop,
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//             child: const Text("Create Shop"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         validator: (value) => value!.isEmpty ? 'Required' : null,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }
// }
