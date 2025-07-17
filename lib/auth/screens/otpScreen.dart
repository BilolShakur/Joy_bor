import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../repositories/auth_repository.dart';
import 'homePage.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    if (otp.length != 6) {
      _showMessage("Iltimos, 6 xonali OTP ni kiriting.");
      return;
    }

    setState(() => isLoading = true);

    final isVerified = await AuthRepository().verifyOtp(
      email: widget.email,
      otp: otp,
    );

    if (isVerified) {
      _showMessage("OTP tasdiqlandi!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Homepage()),
      );
    } else {
      _showMessage("Xatolik! Noto‘g‘ri yoki muddati o‘tgan OTP.");
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/Ellipse.png', width: 180),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tasdiqlash kodi",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Email manzilingizga yuborilgan 6 xonali OTP kodni kiriting.",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(color: Colors.white),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white10,
                      selectedFillColor: Colors.white12,
                      inactiveFillColor: Colors.white10,
                      activeColor: Colors.white24,
                      selectedColor: Colors.yellow,
                      inactiveColor: Colors.white24,
                    ),
                    animationType: AnimationType.fade,
                    enableActiveFill: true,
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC727),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              "Tasdiqlash",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
}
