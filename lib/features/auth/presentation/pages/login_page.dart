import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/presentation/widgets/custon_button.dart';
import 'package:joy_bor/features/auth/presentation/widgets/dont_have_text.dart';
import 'package:joy_bor/features/auth/presentation/widgets/terms_text.dart';

import '../bloc/login_cubit.dart';

import 'signup_page.dart';
import 'otp_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    onSignIn() {
      //? navige to singin
      Navigator.pushNamed(context, "/signup");
    }

    return BlocProvider(
      create: (_) => LoginCubit(AuthRepository()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is LoginOtpSent) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OtpScreen(email: state.email)),
            );
          }
        },
        child: Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 36.h),
                          SizedBox(
                            height: 44.h,
                            width: 174.w,
                            child: Image.asset(AppImages.logo),
                          ),

                          SizedBox(height: 83.h),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "email_address".tr(),
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: emailController,
                                label: "email_address".tr(),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : CustonButton(
                                  label: "sign_in".tr(),
                                  onTap: () {
                                    final email = emailController.text.trim();
                                    if (email.isNotEmpty) {
                                      context.read<LoginCubit>().login(email);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Enter your email."),
                                        ),
                                      );
                                    }
                                  },
                                ),
                          SizedBox(height: 10.h),
                          DontHaveText(
                            firstText: "dont_have_account".tr(),
                            textbutton: "sign_up".tr(),
                            ontap: onSignIn,
                          ),
                          SizedBox(height: 327.h),
                          const TermsText(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
