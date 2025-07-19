import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/features/on_boarding/widgets/custom_button.dart';
import 'package:joy_bor/features/on_boarding/widgets/skip_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/page_indicator.dart';
import '../widgets/onboarding_screen_data.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int index = 0;

  Future<void> nextPage() async {
    if (index < onboardingData.length - 1) {
      controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', true);
      final token = prefs.getString('token');
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (i) => setState(() => index = i),
            itemCount: onboardingData.length,
            itemBuilder: (context, i) =>
                OnboardingScreenData(data: onboardingData[i]),
          ),

          Positioned(
            left: 25.w,
            bottom: 181.h,
            child: PageIndicatorWidget(currentIndex: index),
          ),
          Positioned(
            left: 25.w,
            right: 25.w,
            bottom: 46.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryButton(label: "Skip", onTap: nextPage),

                PrimaryButton(
                  label: index == onboardingData.length - 1
                      ? "Get Started"
                      : "Next",
                  onTap: nextPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
