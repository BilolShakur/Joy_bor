import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:joy_bor/core/constants/app_colors.dart';

class LanguageRow extends StatelessWidget {
  final VoidCallback onChoice;

  final String title;

  const LanguageRow({Key? key, required this.onChoice, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 22.h),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
