import 'package:flutter/material.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("✅ Ro‘yxatdan muvaffaqiyatli o‘tildi!"),
              ),
            );
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tasdiqlash kodi",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "E-pochta manzilingizga yuborilgan 6 xonali kodni kiriting.",
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 16),
              Text(widget.email, style: const TextStyle(color: Colors.white)),
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
                label: "",

                onTap: () {
                  if (otpCode.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Iltimos, 6 xonali OTP kiriting."),
                      ),
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
              // If you want to add resend OTP, implement it in the new OtpCubit and add here
            ],
          ),
        ),
      ),
    );
  }
}
