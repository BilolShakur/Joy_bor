import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:joy_bor/features/auth/presentation/widgets/arrow_back_leading.dart';
import 'package:joy_bor/features/auth/presentation/widgets/custon_button.dart';
import '../bloc/otp_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../home/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(AuthRepository()),
      child: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is OtpSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("otp_success".tr())));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
              (route) => false,
            );
          }
        },
        child: _OtpScreenBody(email: email),
      ),
    );
  }
}

class _OtpScreenBody extends StatefulWidget {
  final String email;

  const _OtpScreenBody({required this.email});

  @override
  State<_OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<_OtpScreenBody> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 100.w,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ArrowBackLeading(),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.bg, fit: BoxFit.cover)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "otp_title".tr(),
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "otp_instruction".tr(),
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.email,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 32),

                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    textStyle: const TextStyle(color: Colors.white),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeColor: Colors.yellow,
                      inactiveColor: Colors.white38,
                      selectedColor: Colors.white,
                      activeFillColor: Colors.white10,
                      inactiveFillColor: Colors.white10,
                      selectedFillColor: Colors.white10,
                    ),
                    enableActiveFill: true,
                    onChanged: (value) => otpCode = value,
                  ),

                  const SizedBox(height: 24),
                  CustonButton(
                    label: "otp_continue".tr(),

                    onTap: () {
                      if (otpCode.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("otp_invalid".tr())),
                        );
                        return;
                      }
                      context.read<OtpCubit>().verifyOtp(
                        email: widget.email,
                        otp: otpCode,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("otp_not_received".tr()),
                      TextButton(
                        onPressed: () {
                          context.read<SignUpCubit>().signUp(
                            email: widget.email,
                          );
                        },
                        child: Text(
                          "otp_resend".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
