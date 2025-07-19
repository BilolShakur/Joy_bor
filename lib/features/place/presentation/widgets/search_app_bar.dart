import 'package:flutter/material.dart';
import '../../../../core/constants/app_images.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(AppImages.arrowBackIcon),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Search",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 70),
        ],
      ),
    );
  }
}
