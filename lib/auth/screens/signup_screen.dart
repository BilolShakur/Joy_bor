import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import 'otpScreen.dart';
import '/auth/screens/homePage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showMessage("Iltimos, email kiriting.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final isRegistered = await AuthRepository().isRegistered(email);

      if (isRegistered) {
        _showMessage("Xush kelibsiz! Email topildi.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage()),
        );
      } else {
        final isSent = await AuthRepository().sendOtp(email);
        if (isSent) {
          _showMessage("OTP yuborildi!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => OtpScreen(email: email)),
          );
        } else {
          _showMessage("OTP yuborishda xatolik.");
        }
      }
    } catch (e) {
      _showMessage("Xatolik yuz berdi: $e");
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Ellipse.png', 
              fit: BoxFit.cover,
            ),
          ),

          // Black gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Foreground content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                const SizedBox(height: 80),
                // Logo
                Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'trav',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'e',
                          style: TextStyle(color: Color(0xFFFFC727), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'la',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                const Text(
                  "Email address",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Enter your email"),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading ? null : _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC727),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("Sign in", style: TextStyle(color: Colors.black)),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "By signing up you agree to our ",
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                      children: [
                        TextSpan(
                          text: "Terms",
                          style: TextStyle(color: Color(0xFFFFC727)),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Conditions of Use",
                          style: TextStyle(color: Color(0xFFFFC727)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
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
