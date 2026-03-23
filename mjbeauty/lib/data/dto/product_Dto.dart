import 'dart:convert';

import 'package:mjbeauty/domain/entities/product.dart';

class ProductDto {
  final int id;
  final String title;
  final double price;
  final String?description;
  final String? category;
  final String? image;

  ProductDto({
  required this.id,
  required this.title,
  required this.price,
  this.description,
  this.category,
  this.image,
});
  factory ProductDto.fromJson (Map<String, dynamic>json) {
    return ProductDto (
    id: json ['id'] as int,
    title: json ['name'] as String,
    price: (json['price'] as num).toDouble(),
    description: json ['desciption'] as String,
    category: json ['category'] as String,
    image: json ['image'] as String,
    );
  }
  Product toEntity() {
    return Product(
      id: id,
      name: title,
      price: price,
      description: description,
      category: category,
      imageUrl: image,
    );
  }
}