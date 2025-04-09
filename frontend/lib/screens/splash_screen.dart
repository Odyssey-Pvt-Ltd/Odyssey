import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxString selectedRole = 'ROLE_CUSTOMER'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildTextField(nameController, "Name"),
            _buildTextField(emailController, "Email"),
            _buildTextField(phoneController, "Phone Number"),
            _buildTextField(addressController, "Address"),
            _buildTextField(passwordController, "Password", isObscure: true),
            _buildTextField(confirmPasswordController, "Confirm Password", isObscure: true),
            const SizedBox(height: 16),
            Obx(() => DropdownButton<String>(
              value: selectedRole.value,
              items: ['ROLE_CUSTOMER', 'ROLE_VENDOR'].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (val) => selectedRole.value = val!,
            )),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                if (passwordController.text != confirmPasswordController.text) {
                  Get.snackbar("Error", "Passwords do not match");
                  return;
                }

                await authController.signUp(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phoneNumber: phoneController.text.trim(),
                  address: addressController.text.trim(),
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  userType: selectedRole.value,
                );
              },
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}