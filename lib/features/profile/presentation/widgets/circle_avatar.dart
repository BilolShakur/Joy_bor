import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';

class CircleAvatarC extends StatelessWidget {
  const CircleAvatarC({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.grey,
      child: Icon(Icons.person),
    );
  }
}
