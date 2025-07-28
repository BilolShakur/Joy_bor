import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:joy_bor/core/constants/app_colors.dart';

class ProfileRow extends StatelessWidget {
  final String header;
  final List<ProfileRowItem> items;

  const ProfileRow({Key? key, required this.header, required this.items})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.grey,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item.to!),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (item.icon != null) ...[
                          item.icon!,
                          SizedBox(width: 16.w),
                        ],
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProfileRowItem {
  final String title;
  final Icon? icon;
  final Widget? to;

  ProfileRowItem({required this.title, this.icon, this.to});
}
