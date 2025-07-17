import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        FaIcon(FontAwesomeIcons.google, color: Colors.white),
        FaIcon(FontAwesomeIcons.apple, color: Colors.white),
        FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
      ],
    );
  }
}