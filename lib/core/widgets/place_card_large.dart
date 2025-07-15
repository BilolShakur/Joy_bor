import 'package:flutter/material.dart';
import 'package:joy_bor/core/constants/app_colors.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';

class PlaceCardLarge extends StatefulWidget {
  final ProductEntity product;

  const PlaceCardLarge({super.key, required this.product});

  @override
  State<PlaceCardLarge> createState() => _PlaceCardLargeState();
}

class _PlaceCardLargeState extends State<PlaceCardLarge> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Image.network(
            widget.product.image,
            height: 265,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.transparent),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.category, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          widget.product.category,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Image.asset(AppImages.star, height: 15, width: 15),
                        SizedBox(width: 4),
                        Text(
                          widget.product.price.toStringAsFixed(1),
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Image.asset(AppImages.open, width: 50, height: 18),
          ),
          Positioned(
            top: 8,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                Icons.favorite,
                color: isFavorite ? AppColors.yellow : Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
