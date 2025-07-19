import 'package:flutter/material.dart';
import 'package:joy_bor/core/widgets/custom_button.dart';
import 'package:joy_bor/core/widgets/page_indicator.dart';
import 'package:joy_bor/features/place/presentation/widgets/onboarding_screen_data.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int index = 0;

  void nextPage() {
    if (index < onboardingData.length - 1) {
      controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/');
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (i) => setState(() => index = i),
                itemCount: onboardingData.length,
                itemBuilder: (context, i) =>
                    OnboardingScreenData(data: onboardingData[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ElevatedButton(
                onPressed: nextPage,
                child: Text(
                  index == onboardingData.length - 1 ? 'Get Startd' : 'Next',
                ),
              ),
            ),
            PageIndicatorWidget(currentIndex: index),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
