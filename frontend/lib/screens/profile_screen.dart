import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_provider.dart';

import 'shop_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();

  Map<String, dynamic>? user;
  bool isVendor = false;
  bool hasShop = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final jwt = authProvider.jwt!;
    final userData = await _apiService.fetchUserProfile(jwt);
    final shops = await _apiService.fetchAllShops(jwt);

    setState(() {
      user = userData;
      isVendor = userData['userType'] == 'ROLE_VENDOR';
      hasShop = shops.any((shop) => shop['user']['id'] == userData['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          _buildTile("Name", user!['name']),
          _buildTile("Email", user!['email']),
          _buildTile("Phone", user!['phoneNumber']),
          _buildTile("Address", user!['address']),
          _buildTile("Role", user!['userType']),
          const SizedBox(height: 20),

          if (isVendor) ...[
            ElevatedButton.icon(
              onPressed: hasShop
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ShopScreen(userId: user!['id'])),
                );
              }
                  : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please create a shop first.")),
                );
              },
              icon: const Icon(Icons.store, color: Colors.white),
              label: const Text("Go to Shop"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: hasShop
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You already have a shop.")),
                );
              }
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ShopScreen(userId: user!['id'])),
                );
              },
              icon: const Icon(Icons.add_business, color: Colors.white),
              label: const Text("Create Shop"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              authProvider.clearJwt();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Divider(height: 24),
      ],
    );
  }
}
