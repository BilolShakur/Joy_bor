class CappadociModel {
  final int id;
  final String name;
  final String description;
  final String fullDescription;
  final String city;
  final String country;
  final String latitude;
  final String longitude;
  final String mainImg;
  final String basePrice;
  final bool isActive;
  final Category category;

  CappadociModel({
    required this.id,
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.mainImg,
    required this.basePrice,
    required this.isActive,
    required this.category,
  });


  factory CappadociModel.fromJson(Map<String, dynamic> json) {
    return CappadociModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      fullDescription: json['full_description'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      mainImg: json['main_img'] ?? '',
      basePrice: json['base_price'] ?? '',
      isActive: json['is_active'] == true || json['is_active'].toString() == 'true',
      category: Category.fromJson(json['category'] ?? {}),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'full_description': fullDescription,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'main_img': mainImg,
      'base_price': basePrice,
      'is_active': isActive,
      'category': category.toJson(),
    };
  }

  @override
  String toString() {
    return '''
🗺️ CappadociModel:
  id: $id
  name: $name
  description: $description
  fullDescription: $fullDescription
  city: $city
  country: $country
  latitude: $latitude
  longitude: $longitude
  mainImg: $mainImg
  basePrice: $basePrice
  isActive: $isActive
  category: $category
''';
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });


  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  @override
  String toString() {
    return '''
🧩 Category:
  id: $id
  name: $name
  description: $description
''';
  }
}