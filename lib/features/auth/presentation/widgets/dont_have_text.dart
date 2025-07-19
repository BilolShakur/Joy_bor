import 'package:flutter/material.dart';

import 'package:joy_bor/core/constants/app_colors.dart';

class DontHaveText extends StatelessWidget {
  final String firstText;
  final String textbutton;
  final VoidCallback ontap;

  const DontHaveText({
    Key? key,
    required this.firstText,
    required this.textbutton,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText),
        TextButton(
          onPressed: ontap,
          child: Text(textbutton, style: TextStyle(color: AppColors.yellow)),
        ),
      ],
    );
  }
}
