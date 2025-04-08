// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:odyssey_app/screens/onboarding_screen.dart';
//
// import '../controllers/auth_controller.dart';
//
// class PasswordSetupScreen extends GetView<AuthController> {
//   final String name;
//   final String email;
//   final String phone;
//
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final TextEditingController securityAnswer1Controller = TextEditingController();
//   final TextEditingController securityAnswer2Controller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   PasswordSetupScreen({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.phone,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Column(
//         children: [
//           // Back Button
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 10),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.black),
//                 onPressed: () => Get.back(),
//               ),
//             ),
//           ),
//           // Content Container
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         const Text(
//                           'Set up a password',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         _buildPasswordField(
//                           controller: passwordController,
//                           hintText: 'Enter your password',
//                         ),
//                         const SizedBox(height: 15),
//                         _buildPasswordField(
//                           controller: confirmPasswordController,
//                           hintText: 'Confirm your password',
//                           validator: (value) {
//                             if (value != passwordController.text) {
//                               return 'Passwords do not match';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 15),
//                         _buildSecurityField(
//                           controller: securityAnswer1Controller,
//                           hintText: 'Security question 1',
//                         ),
//                         const SizedBox(height: 15),
//                         _buildSecurityField(
//                           controller: securityAnswer2Controller,
//                           hintText: 'Security question 2',
//                         ),
//                       ],
//                     ),
//                     Obx(() => ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: controller.isLoading.value ? null : _handleSignup,
//                       child: controller.isLoading.value
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                         'Finish',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hintText,
//     FormFieldValidator<String>? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: true,
//       validator: validator ?? (value) {
//         if (value == null || value.isEmpty) return 'Please enter a password';
//         if (value.length < 6) return 'Password must be at least 6 characters';
//         return null;
//       },
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//       ),
//     );
//   }
//
//   Widget _buildSecurityField({
//     required TextEditingController controller,
//     required String hintText,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) return 'Please answer this question';
//         return null;
//       },
//     );
//   }
//
//   void _handleSignup() {
//     if (_formKey.currentState!.validate()) {
//       controller.signUp(
//         name: name,
//         email: email,
//         phone: phone,
//         password: passwordController.text,
//         securityAnswer1: securityAnswer1Controller.text,
//         securityAnswer2: securityAnswer2Controller.text,
//       );
//     }
//   }
// }