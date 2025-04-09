import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';
import 'listing_screen.dart'; // 👈 make sure this exists

class ShopScreen extends StatefulWidget {
  final int userId;

  const ShopScreen({super.key, required this.userId});

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

  void _submitShop() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.jwt;

    final dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:8081/api',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ));

    final body = {
      "userId": widget.userId,
      "shopName": shopNameController.text.trim(),
      "description": descriptionController.text.trim(),
      "address": {
        "street": streetController.text.trim(),
        "city": cityController.text.trim(),
      },
      "phoneNumber": phoneController.text.trim(),
      "images": []
    };

    try {
      setState(() => isSubmitting = true);
      final response = await dio.put("/admin/shop", data: body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shop created successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Shop"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(shopNameController, "Shop Name"),
              _buildField(descriptionController, "Description"),
              _buildField(streetController, "Street"),
              _buildField(cityController, "City"),
              _buildField(phoneController, "Phone Number"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitShop,
                child: isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListingScreen(shopId: widget.userId)),
                  );
                },
                child: const Text("Go to Listing"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
