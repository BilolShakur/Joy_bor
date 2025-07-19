import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_images.dart';
import '../../place/domain/entities/onboarding_entity.dart';
import 'package:flutter/material.dart';

final List<OnboardingEntities> onboardingData = [
  OnboardingEntities(
    title: 'Where do you want to discover?',
    subtitle: """We've got everything you need 
to go big in 2023.""",
    image: AppImages.onboarding1,
  ),
  OnboardingEntities(
    title: 'Which places are you eager to explore?',
    subtitle: """We've got everything you need
to go big in 2023.""",
    image: AppImages.onboarding2,
  ),
  OnboardingEntities(
    title: '""Where do you want to go next?',
    subtitle: """We've got everything you need
to go big in 2023.""",
    image: AppImages.onboarding3,
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

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 226.h,
          left: 25.w,
          right: 25.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                data.subtitle,

                style: TextStyle(color: Colors.white70, fontSize: 20.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
