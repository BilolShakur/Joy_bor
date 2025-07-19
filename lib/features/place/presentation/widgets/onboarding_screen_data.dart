import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/place/domain/entities/onboarding_entity.dart';
import 'package:flutter/material.dart';

final List<OnboardingEntities> onboardingData = [
  OnboardingEntities(
    title: 'Where do you want to discover?',
    subtitle: "We've got everything you need to go big in 2023.",
    image: AppImages.onboarding1,
    bottomfon: AppImages.blackfon,
  ),
  OnboardingEntities(
    title: 'Which places are you eager to explore?',
    subtitle: "We've got everything you need to go big in 2023.",
    image: AppImages.onboarding2,
    bottomfon: AppImages.blackfon,
  ),
  OnboardingEntities(
    title: 'Where do you want to go next?',
    subtitle: "We've got everything you need to go big in 2023.",
    image: AppImages.onboarding3,
    bottomfon: AppImages.blackfon,
  ),
];

class OnboardingScreenData extends StatelessWidget {
  final OnboardingEntities data;
  const OnboardingScreenData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          data.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 320,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(data.bottomfon, fit: BoxFit.cover),
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
                        data.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data.subtitle,
                        style: TextStyle(color: Colors.white70, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
