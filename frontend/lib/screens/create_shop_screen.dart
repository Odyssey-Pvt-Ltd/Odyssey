import 'package:flutter/material.dart';

import '../services/api_service.dart';


class CreateShopScreen extends StatefulWidget {
  final int userId;

  const CreateShopScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<CreateShopScreen> createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  bool _loading = false;

  Future<void> _submitShop() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await _apiService.createShop(
        userId: widget.userId,
        shopName: _shopName.text.trim(),
        description: _description.text.trim(),
        street: _street.text.trim(),
        city: _city.text.trim(),
        phoneNumber: _phone.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shop created successfully")),
      );

      Navigator.pop(context); // go back to profile or wherever
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create shop")),
      );
    } finally {
      setState(() => _loading = false);
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
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(_shopName, "Shop Name"),
              _buildField(_description, "Description"),
              _buildField(_street, "Street"),
              _buildField(_city, "City"),
              _buildField(_phone, "Phone Number"),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitShop,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text("Create Shop"),
              )
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
        validator: (value) => value!.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
