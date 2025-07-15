import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/core/widgets/price_range_slider.dart';
import 'package:joy_bor/core/widgets/star_reting_item.dart';
import 'section_title.dart';
import 'category.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int selectedRating = 5;
  String selectedCategory = 'Home';
  RangeValues selectedRange = RangeValues(100, 450);

  final categories = [
    "Home",
    "Apartment",
    "Homestay",
    "Villa",
    "Townhouse",
    "Condo",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splash2),
          fit: BoxFit.cover,
        ),
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SectionTitle("Category"),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  categories.map((cat) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedCategory = cat);
                      },
                      child: Category(
                        label: cat,
                        selected: selectedCategory == cat,
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            SectionTitle("Rating"),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() => selectedRating = index + 1);
                  },
                  child: StarRatingItem(
                    star: index + 1,
                    isSelected: index < selectedRating,
                  ),
                ), 
              ),
            ),
            SizedBox(height: 20),
            SectionTitle("Range Price"),
            SizedBox(height: 10),
            PriceRangeSlider(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
