import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ShopScreen extends StatefulWidget {
  final int userId;

  const ShopScreen({super.key, required this.userId}); // ✅ Accept userId

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isSubmitting = false;
  List<dynamic> shops = [];

  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8081/api',
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  @override
  void initState() {
    super.initState();
    _fetchShops();
  }

  void _fetchShops() async {
    try {
      final response = await dio.get("/shop");
      setState(() {
        shops = response.data;
      });
    } catch (e) {
      print("❌ Failed to load shops: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch shops")),
      );
    }
  }

  void _submitShop() async {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      "userId": widget.userId,
      "shopName": shopNameController.text.trim(),
      "description": descriptionController.text.trim(),
      "address": {
        "street": streetController.text.trim(),
        "city": cityController.text.trim(),
      },
      "phoneNumber": phoneController.text.trim(),
      "images": [] // You can update this later to handle images
    };

    try {
      setState(() => isSubmitting = true);
      await dio.put("/admin/shop", data: body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Shop created successfully")),
      );
      _fetchShops(); // Refresh shop list
      _formKey.currentState!.reset(); // Reset form
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
        (value == null || value.isEmpty) ? "$label is required" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildShopCard(dynamic shop) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(shop['shopName'] ?? "Unnamed Shop"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shop['description'] ?? "No description"),
            if (shop['address'] != null)
              Text("📍 ${shop['address']['street']}, ${shop['address']['city']}"),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Shops"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField(shopNameController, "Shop Name"),
                  _buildField(descriptionController, "Description"),
                  _buildField(streetController, "Street"),
                  _buildField(cityController, "City"),
                  _buildField(phoneController, "Phone Number"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isSubmitting ? null : _submitShop,
                    child: isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Create Shop"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "All Shops",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (shops.isEmpty)
              const Text("No shops available.")
            else
              ...shops.map((shop) => _buildShopCard(shop)).toList(),
          ],
        ),
      ),
    );
  }
}
