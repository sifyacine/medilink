import 'package:medilink/features/main_pages/models/pharmacy.dart';
import 'package:medilink/features/main_pages/models/reviews_model.dart';


class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final int stock;
  final Pharmacy manufacturer;
  final String category;
  final String size;
  final String material;
  final int reductionPercentage;
  final bool isAvailable;
  final DateTime addedDate;
  final List<Review> ratings;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.stock,
    required this.manufacturer,
    required this.category,
    required this.size,
    required this.material,
    required this.reductionPercentage,
    required this.isAvailable,
    required this.addedDate,
    this.ratings = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      stock: json['stock'],
      manufacturer: Pharmacy.fromJson(json['manufacturer']),
      category: json['category'],
      size: json['size'],
      material: json['material'],
      reductionPercentage: json['reduction_percentage'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      addedDate: DateTime.parse(json['added_date']),
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'price': price,
    'description': description,
    'stock': stock,
    'manufacturer': manufacturer.toJson(),
    'category': category,
    'size': size,
    'material': material,
    'reduction_percentage': reductionPercentage,
    'is_available': isAvailable,
    'added_date': addedDate.toIso8601String(),
    'ratings': ratings.map((e) => e.toJson()).toList(),
  };
}
