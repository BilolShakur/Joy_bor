import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import 'otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_cubit.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.white38),
    filled: true,
    fillColor: Colors.white10,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SignUpSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("OTP yuborildi!")));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OtpScreen(
                  fullName: state.fullName,
                  email: state.email,
                  password: state.password,
                ),
              ),
            );
          }
        },
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            final isLoading = state is SignUpLoading;
            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  children: [
                    const SizedBox(height: 40),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextField(
                      controller: nameController,
                      label: "Full Name",
                    ),

                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                    ),

                    CustomTextField(
                      controller: passwordController,
                      label: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 24),
                    CustomButton(
                      title: "Sign Up",
                      isLoading: isLoading,
                      onPressed: () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        context.read<SignUpCubit>().signUp(
                          fullName: name,
                          email: email,
                          password: password,
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white60),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Color(0xFFFFC727)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text.rich(
                      TextSpan(
                        text: "By signing up you agree to our ",
                        children: [
                          TextSpan(
                            text: "Terms ",
                            style: TextStyle(color: Color(0xFFFFC727)),
                          ),
                          TextSpan(text: "and "),
                          TextSpan(
                            text: "Conditions of Use",
                            style: TextStyle(color: Color(0xFFFFC727)),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
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
