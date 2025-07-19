import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../repositories/auth_repository.dart';
import 'home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_cubit.dart';
import '../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  final String fullName;
  final String email;
  final String password;

  const OtpScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(),
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
              MaterialPageRoute(builder: (_) => const Homepage()),
              (route) => false,
            );
          } else if (state is OtpResent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("🔁 Yangi OTP yuborildi.")),
            );
          }
        },
        child: _OtpScreenBody(
          fullName: fullName,
          email: email,
          password: password,
        ),
      ),
    );
  }
}

class _OtpScreenBody extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const _OtpScreenBody({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  State<_OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<_OtpScreenBody> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<OtpCubit>().state is OtpLoading;
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
              CustomButton(
                title: "Tasdiqlash",
                isLoading: isLoading,
                onPressed: () {
                  if (otpCode.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Iltimos, 6 xonali OTP kiriting."),
                      ),
                    );
                    return;
                  }
                  context.read<OtpCubit>().verifyOtp(
                    fullName: widget.fullName,
                    email: widget.email,
                    password: widget.password,
                    otp: otpCode,
                  );
                },
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.read<OtpCubit>().resendOtp(widget.email),
                  child: const Text(
                    "Kodni qayta yuborish",
                    style: TextStyle(color: Color(0xFFFFC727)),
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
