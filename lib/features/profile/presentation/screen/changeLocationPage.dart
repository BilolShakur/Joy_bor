import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/core/constants/language_helper.dart';

class ChangeLocationPage extends StatelessWidget {
  const ChangeLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.bg)),
          Container(color: Colors.black.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const BackButton(color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          LocaleKeys.changeLocation.tr(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/profil.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    locationField(
                      LocaleKeys.country.tr(),
                      LocaleKeys.country
                          .tr(), // or a separate hint if you have one
                    ),
                    locationField(LocaleKeys.city.tr(), LocaleKeys.city.tr()),
                    locationField(LocaleKeys.zip.tr(), LocaleKeys.zip.tr()),
                    locationField(
                      LocaleKeys.address.tr(),
                      LocaleKeys.address.tr(),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // TODO: implement update logic
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            LocaleKeys.update.tr(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget locationField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white60),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
