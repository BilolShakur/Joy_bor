import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/data/auth_repository.dart';
import 'package:joy_bor/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/auth/presentation/widgets/custon_button.dart';
import 'package:joy_bor/features/auth/presentation/widgets/dont_have_text.dart';
import 'package:joy_bor/features/auth/presentation/widgets/terms_text.dart';
import '../widgets/custom_textfield.dart';
import 'otp_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => SignUpCubit(AuthRepository()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SignUpOtpSent) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("OTP yuborildi!")));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OtpScreen(email: state.email)),
            );
          }
        },
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            final isLoading = state is SignUpLoading;

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leadingWidth: 300.w,
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: EdgeInsets.only(left: 22.w),
                  child: Row(children: [ArrowBackLeading()]),
                ),
              ),
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(AppImages.bg, fit: BoxFit.cover),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "create_account".tr(),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                "enter_your_email".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: nameController,
                                label: "John Soen",
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                "email_address".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: emailController,
                                label: "email_address".tr(),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                "password".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: passwordController,
                                label: "Password".tr(),
                                obscureText: true,
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                          isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : CustonButton(
                                  label: "Sign Up",
                                  onTap: () {
                                    final name = nameController.text.trim();
                                    final email = emailController.text.trim();
                                    final password = passwordController.text
                                        .trim();

                                    if (name.isNotEmpty &&
                                        email.isNotEmpty &&
                                        password.isNotEmpty) {
                                      context.read<SignUpCubit>().signUp(
                                        email: email,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Fill all fields."),
                                        ),
                                      );
                                    }
                                  },
                                ),
                          SizedBox(height: 10.h),
                          DontHaveText(
                            firstText: "Already have an account?",
                            textbutton: "Sign in here",
                            ontap: () {},
                          ),
                          SizedBox(height: 113.h),
                          const TermsText(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
