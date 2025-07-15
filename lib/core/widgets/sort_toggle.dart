import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';

class SortItem {
  final String imagePath;
  final String label;

  SortItem({required this.imagePath, required this.label});
}

class SortToggleButtons extends StatelessWidget {
  final List<SortItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SortToggleButtons({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final isSelected = index == selectedIndex;
        final item = items[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              height: 50,
              duration: Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.yellow : Colors.grey.withAlpha(40),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    item.imagePath,
                    width: 20,
                    height: 20,
                    color: isSelected ? Colors.black : AppColors.grey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? Colors.black : AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
