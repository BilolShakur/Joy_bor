import 'package:flutter/material.dart';
import '../bloc/signup_cubit.dart';

import 'otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../../data/auth_repository.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final countryController = TextEditingController();
    final cityController = TextEditingController();
    final zipController = TextEditingController();
    final addressController = TextEditingController();
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
                      controller: phoneController,
                      label: "Phone Number",
                    ),
                    CustomTextField(
                      controller: countryController,
                      label: "Country",
                    ),
                    CustomTextField(controller: cityController, label: "City"),
                    CustomTextField(controller: zipController, label: "Zip"),
                    CustomTextField(
                      controller: addressController,
                      label: "Address",
                    ),

                    const SizedBox(height: 24),
                    CustomButton(
                      label: "",
                      label2: "Sign Up",
                      onTap: () {
                        context.read<SignUpCubit>().signUp(
                          fullName: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          country: countryController.text.trim(),
                          city: cityController.text.trim(),
                          zip: zipController.text.trim(),
                          address: addressController.text.trim(),
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
