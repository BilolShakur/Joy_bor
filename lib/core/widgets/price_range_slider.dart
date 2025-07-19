import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues selectedRange = RangeValues(100, 450);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        RangeSlider(
          values: selectedRange,
          min: 100,
          max: 800,
          divisions: 14,
          activeColor: AppColors.yellow,
          inactiveColor: AppColors.grey,
          onChanged: (values) {
            setState(() => selectedRange = values);
          },
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 30,
          child: Stack(
            children: [
              Positioned(
                left: width * ((selectedRange.start - 100) / 700),
                child: Text(
                  '\$${selectedRange.start.toInt()}',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                left: width * ((selectedRange.end - 100) / 700) - 20,
                child: Text(
                  '\$${selectedRange.end.toInt()}',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Text(
                  '\$800',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
