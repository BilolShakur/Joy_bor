import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_colors.dart';

class ArrowBackLeading extends StatelessWidget {
  const ArrowBackLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(Icons.arrow_back)),
    );
  }
}
