import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/presentation/bloc/login_cubit.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/auth/presentation/widgets/custon_button.dart';
import 'package:joy_bor/features/auth/presentation/widgets/dont_have_text.dart';
import 'package:joy_bor/features/auth/presentation/widgets/terms_text.dart';
import '../bloc/signup_cubit.dart';

import 'otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_textfield.dart';

import '../../data/auth_repository.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

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
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          final isLoading = state is LoginLoading;

                          return Column(
                            children: [
                              SizedBox(height: 16.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create Your Account",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  Text(
                                    "Enter name",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    controller: emailController,
                                    label: "John soen",
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    "Email address",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    controller: emailController,
                                    label: "Email address",
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    "Password",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    obscureText: true,
                                    controller: emailController,
                                    label: "Password",
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      IconButton(
                                        iconSize: 30.h,
                                        onPressed: () {},
                                        icon: Icon(Icons.circle_outlined),
                                      ),
                                      Text("Remember Me"),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.h),

                              isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : CustonButton(
                                      label: "Sign in",
                                      onTap: () {
                                        final email = emailController.text
                                            .trim();
                                        if (email.isNotEmpty) {
                                          context.read<LoginCubit>().login(
                                            email,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Enter your email.",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                              SizedBox(height: 10.h),
                              DontHaveText(
                                firstText: "Already have an account ?",
                                textbutton: "Sign in here",
                                ontap: () {},
                              ),
                              SizedBox(height: 113.h),
                              const TermsText(),
                            ],
                          );
                        },
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
