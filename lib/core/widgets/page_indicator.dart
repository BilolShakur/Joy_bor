import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentIndex;

  const PageIndicatorWidget({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 55,
          height: 3,
          decoration: BoxDecoration(
            color: currentIndex == i ? Colors.white : Colors.grey.shade800,
          ),
        );
      }),
    );
  }
}
