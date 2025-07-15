import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../repositories/auth_repository.dart';
import 'homePage.dart';

class OtpScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const OtpScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    if (otpCode.length != 6) {
      _showMessage("Iltimos, 6 xonali OTP kiriting.");
      return;
    }

    setState(() => isLoading = true);

    final success = await AuthRepository().activate(
      fullName: widget.fullName,
      email: widget.email,
      password: widget.password,
      confirmPassword: widget.password,
      otp: otpCode,
    );

    setState(() => isLoading = false);

    if (success) {
      _showMessage("✅ Ro‘yxatdan muvaffaqiyatli o‘tildi!");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Homepage()),
        (route) => false,
      );
    } else {
      _showMessage("❌ Noto‘g‘ri OTP yoki muddati tugagan.");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _resendOtp() async {
    setState(() => isLoading = true);
    final success = await AuthRepository().sendOtp(widget.email);
    setState(() => isLoading = false);

    if (success) {
      _showMessage("🔁 Yangi OTP yuborildi.");
    } else {
      _showMessage("❌ OTP yuborishda xatolik.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tasdiqlash kodi",
                style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "E-pochta manzilingizga yuborilgan 6 xonali kodni kiriting.",
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 16),
              Text(widget.email, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 32),

              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                textStyle: const TextStyle(color: Colors.white),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeColor: Colors.yellow,
                  inactiveColor: Colors.white38,
                  selectedColor: Colors.white,
                  activeFillColor: Colors.white10,
                  inactiveFillColor: Colors.white10,
                  selectedFillColor: Colors.white10,
                ),
                enableActiveFill: true,
                onChanged: (value) => otpCode = value,
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC727),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("Tasdiqlash", style: TextStyle(color: Colors.black)),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: isLoading ? null : _resendOtp,
                  child: const Text(
                    "Kodni qayta yuborish",
                    style: TextStyle(color: Color(0xFFFFC727)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
