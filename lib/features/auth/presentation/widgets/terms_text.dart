import 'package:easy_localization/easy_localization.dart';
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
              "signup_agree".tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("terms".tr(), style: TextStyle(color: AppColors.yellow)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("and".tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            Text("conditions".tr(), style: TextStyle(color: AppColors.yellow)),
          ],
        ),
      ],
    );
  }
}
