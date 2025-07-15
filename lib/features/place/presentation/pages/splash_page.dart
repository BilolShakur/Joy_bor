import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/place/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => OnboardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.splash, fit: BoxFit.cover),
          Center(child: Image.asset(AppImages.travela, width: 170, height: 40)),
        ],
      ),
    );
  }
}
