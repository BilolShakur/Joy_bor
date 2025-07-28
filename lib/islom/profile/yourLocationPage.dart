import 'package:flutter/material.dart';

class YourLocationPage extends StatelessWidget {
  const YourLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Ellipse.png', // rasm yo'li
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButton(color: Colors.white),
                      const SizedBox(width: 10),
                      const Text(
                        "Your Location",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/profil.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  locationCard(true),
                  const SizedBox(height: 20),
                  locationCard(false),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget locationCard(bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.yellow : Colors.transparent,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.yellow),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "Brooklyn Simmons",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? Colors.yellow : Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "+1 3712 3789\n711 Leavenworth Apt. #47 San Francisco, CA 94109",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.yellow),
              foregroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text("Change Address"),
          ),
        ],
      ),
    );
  }
}
