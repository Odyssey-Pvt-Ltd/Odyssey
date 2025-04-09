import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odyssey_app/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController _authController = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final RxString _userType = 'ROLE_CUSTOMER'.obs;

  final _formKey = GlobalKey<FormState>();

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      _authController.signUp(
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        password: _passwordController.text,
        userType: _userType.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.jpeg',
                width: 400,
                height: 300,
              ),
              const SizedBox(height: 20),
              _buildAuthToggle(),
              const SizedBox(height: 30),
              _buildSignupForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: Get.back,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                    'Signup',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildNameField(),
          const SizedBox(height: 15),
          _buildEmailField(),
          const SizedBox(height: 15),
          _buildPhoneField(),
          const SizedBox(height: 15),
          _buildAddressField(),
          const SizedBox(height: 15),
          _buildUserTypeDropdown(),
          const SizedBox(height: 15),
          _buildPasswordField(),
          const SizedBox(height: 15),
          _buildConfirmPasswordField(),
          const SizedBox(height: 20),
          _buildSignupButton(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _inputDecoration('Full Name'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your name';
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _inputDecoration('Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: _inputDecoration('Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your phone number';
        if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: _inputDecoration('Address'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your address';
        return null;
      },
    );
  }

  Widget _buildUserTypeDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
      value: _userType.value,
      items: const [
        DropdownMenuItem(
            value: 'ROLE_VENDOR',
            child: Text('Vendor')
        ),
        DropdownMenuItem(
            value: 'ROLE_CUSTOMER',
            child: Text('Customer')
        ),
      ],
      onChanged: (value) => _userType.value = value!,
      decoration: _inputDecoration('User Type'),
      validator: (value) {
        if (value == null) return 'Please select user type';
        return null;
      },
    ));
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: _inputDecoration('Password'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter password';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: _inputDecoration('Confirm Password'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please confirm password';
        if (value != _passwordController.text) return 'Passwords do not match';
        return null;
      },
    );
  }

  Widget _buildSignupButton() {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _authController.isLoading.value ? null : _handleSignup,
        child: _authController.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[100],
    );
  }
}