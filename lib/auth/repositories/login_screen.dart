// import 'package:flutter/material.dart';
// import '../repositories/auth_repository.dart';
// import '../widgets/social_buttons.dart';
// import '../widgets/custom_textfield.dart';
// import '../widgets/custom_button.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final authRepo = AuthRepository();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
//         child: ListView(
//           children: [
//             const SizedBox(height: 40),
//             const Text(
//               "travela",
//               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 40),
//             CustomTextField(
//               controller: emailController,
//               label: "Email address",
//             ),
//             CustomTextField(
//               controller: passwordController,
//               label: "Password",
//               obscureText: true,
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Expanded(
//                   child: Row(
//                     children: [
//                       Icon(Icons.circle_outlined, size: 18),
//                       SizedBox(width: 4),
//                       Text("Remember Me"),
//                     ],
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text("Reset Password"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             CustomButton(
//               title: "Sign in",
//               onPressed: () async {
//                 bool result = await authRepo.login(
//                   emailController.text,
//                   passwordController.text,
//                 );
//                 final message = result ? "Login Successful" : "Login Failed";
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text(message)));
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Don’t have an account?"),
//                 TextButton(
//                   onPressed: () => Navigator.pushNamed(context, '/signup'),
//                   child: const Text("Sign Up"),
//                 ),
//               ],
//             ),
//             const Divider(height: 40),
//             const Center(child: Text("Or Sign In with")),
//             const SizedBox(height: 10),
//             const SocialButtons(),
//             const SizedBox(height: 20),
//             const Center(
//               child: Text.rich(
//                 TextSpan(
//                   text: "By signing up you agree to our ",
//                   children: [
//                     TextSpan(
//                       text: "Terms ",
//                       style: TextStyle(color: Colors.yellow),
//                     ),
//                     TextSpan(text: "and "),
//                     TextSpan(
//                       text: "Conditions of Use",
//                       style: TextStyle(color: Colors.yellow),
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
