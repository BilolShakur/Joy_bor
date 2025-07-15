import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final String label2;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 70,
            width: 270,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: Text(
                label2,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
