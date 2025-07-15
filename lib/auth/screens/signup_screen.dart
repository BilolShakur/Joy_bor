import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import 'otpScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("Iltimos, barcha maydonlarni to‘ldiring.");
      return;
    }

    setState(() => isLoading = true);

    // Foydalanuvchini ro'yxatdan o'tkazish
    final isSignedUp = await AuthRepository().signUpUser(
      fullName: name,
      email: email,
      password: password,
    );

    setState(() => isLoading = false);

    if (isSignedUp) {
      _showMessage("OTP yuborildi!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            fullName: name,
            email: email,
            password: password,
          ),
        ),
      );
    } else {
      _showMessage("Bu email allaqachon ro‘yxatdan o‘tgan.");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "Create Your Account",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text("Full Name", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Enter your name"),
            ),

            const SizedBox(height: 16),
            const Text("Email", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Enter your email"),
            ),

            const SizedBox(height: 16),
            const Text("Password", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Enter your password"),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _handleSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC727),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text("Sign Up", style: TextStyle(color: Colors.black)),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: Colors.white60)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Sign In", style: TextStyle(color: Color(0xFFFFC727))),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text.rich(
              TextSpan(
                text: "By signing up you agree to our ",
                children: [
                  TextSpan(text: "Terms ", style: TextStyle(color: Color(0xFFFFC727))),
                  TextSpan(text: "and "),
                  TextSpan(text: "Conditions of Use", style: TextStyle(color: Color(0xFFFFC727))),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );
}
