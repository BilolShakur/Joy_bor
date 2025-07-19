import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> _navigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('onboarding_complete') != true;
    final token = prefs.getString('token');
    if (isFirstLaunch) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else if (token != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate(context));
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.bg),

          Center(child: Image.asset(AppImages.logo, width: 170, height: 40)),
        ],
      ),
    );
  }
}
