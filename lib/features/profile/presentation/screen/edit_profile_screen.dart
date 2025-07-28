import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_images.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.bg)),

          Container(color: Colors.black.withOpacity(0.5)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 30),

                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/profil.png'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Change profile picture',
                      style: TextStyle(
                        color: Colors.yellow,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  _buildLabel('Full Name'),
                  _buildTextField(hint: 'Enter your name'),

                  const SizedBox(height: 20),

                  _buildLabel('Email Address'),
                  _buildTextField(hint: 'Enter your email'),

                  const SizedBox(height: 20),

                  _buildLabel('Phone Number'),
                  Row(
                    children: [
                      SizedBox(width: 80, child: _buildTextField(hint: '+998')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField(hint: '90 123 4567')),
                    ],
                  ),
                  const SizedBox(height: 200),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: () {},
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.yellow,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint),
    );
  }
}
