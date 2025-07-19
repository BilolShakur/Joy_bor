import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/filter_bottom_sheet.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(40),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black,
                  builder: (_) => FilterBottomSheet(),
                );
              },
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(13),
                  child: Image.asset(AppImages.filter),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
