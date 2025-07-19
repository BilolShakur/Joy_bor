import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

class SearchResults extends StatelessWidget {
  final List<ProductEntity> results;
  final Function(ProductEntity) onTap;

  const SearchResults({super.key, required this.results, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return GestureDetector(
          onTap: () => onTap(product),
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, __) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey,
                      child: Icon(Icons.image, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
