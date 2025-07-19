import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By signing up you agree to our  ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Terms", style: TextStyle(color: AppColors.yellow)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("and  ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "Conditions of Use",
              style: TextStyle(color: AppColors.yellow),
            ),
          ],
        ),
      ],
    );
  }
}
