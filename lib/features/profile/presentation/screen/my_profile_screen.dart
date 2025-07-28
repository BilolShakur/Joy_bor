import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/notification/presentation/pages/notification_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/changeLocationPage.dart';
import 'package:joy_bor/features/profile/presentation/screen/change_password_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/language_screen.dart';
import 'package:joy_bor/features/profile/presentation/widgets/circle_avatar.dart';
import 'package:joy_bor/features/profile/presentation/widgets/profile_row.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ArrowBackLeading(),
                    SizedBox(width: 105.w),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    SizedBox(height: 56.h, width: 56.w, child: CircleAvatarC()),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("John Doe", style: TextStyle(fontSize: 18.sp)),
                        Text(
                          "Queens Eyeland",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ProfileRow(
                  items: [
                    ProfileRowItem(
                      title: "Edit Profile ",
                      icon: Icon(Icons.person),
                      to: EditProfilePage(),
                    ),
                    ProfileRowItem(
                      title: "E'lon joylash",
                      icon: Icon(Icons.bed),
                    ),
                    ProfileRowItem(
                      to: ChangeLocationPage(),
                      title: "My Lcoation",
                      icon: Icon(Icons.location_pin),
                    ),
                  ],
                  header: 'Personal info',
                ),
                SizedBox(height: 16.h),
                ProfileRow(
                  items: [
                    ProfileRowItem(
                      to: ChangePasswordScreen(),
                      title: "Change Password",
                      icon: Icon(Icons.lock_outline_rounded),
                    ),
                  ],
                  header: 'Security',
                ),
                SizedBox(height: 16.h),
                ProfileRow(
                  items: [
                    ProfileRowItem(
                      to: NotificationScreen(),
                      title: "Notifications",
                      icon: Icon(Icons.notifications),
                    ),
                    ProfileRowItem(
                      to: LanguageScreen(),
                      title: "Language",
                      icon: Icon(Icons.language),
                    ),
                    ProfileRowItem(
                      title: "Help and support",
                      icon: Icon(Icons.help_outline),
                    ),
                  ],
                  header: 'General',
                ),
                SizedBox(height: 24.h),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: AppColors.yellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
