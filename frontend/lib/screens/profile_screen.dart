import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_provider.dart';

import 'create_shop_screen.dart';
import 'shop_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  bool isVendor = false;
  Map<String, dynamic>? user;
  Map<String, dynamic>? shop;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final userProfile = await _apiService.getUserProfile();
      final userData = userProfile.data;
      final userType = userData['userType'];

      setState(() {
        user = userData;
        isVendor = userType == 'ROLE_VENDOR';
      });

      if (isVendor) {
        try {
          final shopResponse = await _apiService.getMyShop();
          setState(() {
            shop = shopResponse.data;
          });
        } catch (e) {
          print("No existing shop found.");
        }
      }
    } catch (e) {
      print("Error fetching user/shop: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 20),
          _buildTile("Name", user!['name']),
          _buildTile("Email", user!['email']),
          _buildTile("Phone", user!['phoneNumber']),
          _buildTile("Address", user!['address']),
          _buildTile("Role", user!['userType']),
          const SizedBox(height: 20),

          if (isVendor) ...[
            ElevatedButton.icon(
              onPressed: shop != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShopScreen(shopData: shop!),
                  ),
                );
              }
                  : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No shop found. Please create one first."),
                  ),
                );
              },
              icon: const Icon(Icons.store, color: Colors.white),
              label: const Text("Go to Shop", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: shop == null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateShopScreen(userId: user!['id']),
                  ),
                );
              }
                  : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have already created a shop."),
                  ),
                );
              },
              icon: const Icon(Icons.add_business, color: Colors.white),
              label: const Text("Create Shop", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
          ],

          ElevatedButton.icon(
            onPressed: () {
              authProvider.clearJwt();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text("Logout", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Divider(height: 24),
      ],
    );
  }
}
