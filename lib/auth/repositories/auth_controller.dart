import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/auth_repository.dart';
import '../screens/otpScreen.dart';
import '../screens/homePage.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void register() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Xatolik', 'Emailni kiriting', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;

      final isRegistered = await AuthRepository().isRegistered(email);

      if (isRegistered) {
        Get.snackbar('Xush kelibsiz!', 'Email topildi!', backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAll(() => Homepage());
      } else {
        final isSent = await AuthRepository().sendOtp(email);
        if (isSent) {
          Get.snackbar('OTP', 'Kod yuborildi!', backgroundColor: Colors.green, colorText: Colors.white);
          Get.to(() => OtpScreen(email: email));
        } else {
          Get.snackbar('Xatolik', 'OTP yuborishda muammo.', backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar('Xatolik', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}