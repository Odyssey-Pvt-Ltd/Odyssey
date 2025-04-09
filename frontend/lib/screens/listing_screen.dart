import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class ListingScreen extends StatefulWidget {
  final int shopId;
  const ListingScreen({required this.shopId});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final ApiService _apiService = Get.find<ApiService>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();

  bool isSubmitting = false;

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "price": double.tryParse(priceController.text.trim()) ?? 0,
      "images": ["image1.jpg"], // Placeholder, use real images if needed
      "shopID": widget.shopId,
      "active": true,
      "category": {
        "id": int.tryParse(categoryIdController.text.trim()) ?? 1,
        "name": categoryNameController.text.trim()
      },
      "listing_type": "RESTUARANTS"
    };

    try {
      setState(() => isSubmitting = true);
      final response = await _apiService.createListing(data);
      Get.snackbar("Success", "Listing created!");
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "Failed to create listing");
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  Widget _buildField(TextEditingController controller, String label,
      {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) =>
        (value == null || value.isEmpty) ? "$label is required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Listing"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(titleController, "Title"),
              _buildField(descriptionController, "Description"),
              _buildField(priceController, "Price", type: TextInputType.number),
              _buildField(categoryIdController, "Category ID",
                  type: TextInputType.number),
              _buildField(categoryNameController, "Category Name"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitListing,
                child: isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Listing"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
