import 'package:flutter/material.dart';

import '../bloc/login_cubit.dart';

import 'signup_page.dart';
import 'otp_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_button.dart';
import '../../data/auth_repository.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
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
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF000000), Color(0xFF1C1C1C)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "travela",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Email address",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      controller: emailController,
                      label: "Email address",
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      label: "",
                      label2: "Login",
                      onTap: () {
                        final email = emailController.text.trim();
                        context.read<LoginCubit>().login(email);
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white60),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Color(0xFFFFC727)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
