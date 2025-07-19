class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  String get image => imageUrl;
  String get title => name;

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String? ?? '',
    );
  }
}
