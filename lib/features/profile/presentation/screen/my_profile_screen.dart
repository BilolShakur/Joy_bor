import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:joy_bor/features/auth/presentation/pages/login_page.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/notification/presentation/pages/notification_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/changeLocationPage.dart';
import 'package:joy_bor/features/profile/presentation/screen/change_password_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/language_screen.dart';
import 'package:joy_bor/features/profile/presentation/screen/terms_screen.dart';
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
                      "my_profile".tr(),
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
                      title: "edit_profile".tr(),
                      icon: Icon(Icons.person),
                      to: EditProfilePage(),
                    ),
                    ProfileRowItem(
                      to: ChangeLocationPage(),
                      title: "change_location".tr(),
                      icon: Icon(Icons.location_pin),
                    ),
                  ],
                  header: 'personal_info'.tr(), // add key to JSON if needed
                ),
                SizedBox(height: 16.h),
                ProfileRow(
                  items: [
                    ProfileRowItem(
                      to: ChangePasswordScreen(),
                      title: "change_password".tr(),
                      icon: Icon(Icons.lock_outline_rounded),
                    ),
                  ],
                  header: 'security'.tr(), // add key to JSON if needed
                ),
                SizedBox(height: 16.h),
                ProfileRow(
                  items: [
                    ProfileRowItem(
                      to: NotificationScreen(),
                      title: "notification".tr(),
                      icon: Icon(Icons.notifications),
                    ),
                    ProfileRowItem(
                      to: LanguageScreen(),
                      title: "language".tr(),
                      icon: Icon(Icons.language),
                    ),
                    ProfileRowItem(
                      to: TermsScreen(),
                      title: "terms_and_conditions_full".tr(),
                      icon: Icon(Icons.help_outline),
                    ),
                  ],
                  header: 'general'.tr(), // add key to JSON if needed
                ),
                SizedBox(height: 24.h),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is logEdOut) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        context.read<SignUpCubit>().logOut();
                      },
                      child: Text(
                        "logout"
                            .tr(), // add this to your JSON: "logout": "Logout"
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: AppColors.yellow,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
