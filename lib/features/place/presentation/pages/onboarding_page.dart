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
    } else {}
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: onboardingData.length,
        onPageChanged: (i) => setState(() => index = i),
        itemBuilder: (context, i) {
          final item = onboardingData[i];
          return Stack(
            children: [
              Image.asset(
                item.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 320,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(item.bottomfon, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Column(
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      PageIndicatorWidget(currentIndex: index),
                      SizedBox(height: 60),
                      CustomButton(
                        label: "Skip",
                        onTap: nextPage,
                        label2: "Get Started",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
