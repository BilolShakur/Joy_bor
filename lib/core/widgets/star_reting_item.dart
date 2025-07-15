import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';

class StarRatingItem extends StatelessWidget {
  final int star;
  final bool isSelected;

  const StarRatingItem({
    super.key,
    required this.star,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.star,
              height: 16,
              color: isSelected ? AppColors.yellow : Colors.grey,
            ),
            SizedBox(width: 4),
            Text('$star', style: TextStyle(color: AppColors.grey)),
          ],
        ),
      ),
    );
  }
}
