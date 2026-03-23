
import 'package:mjbeauty/domain/entities/product.dart';

class DummyProductDTO {
  static ProductEntity fromJson(Map<String, dynamic> json, {int index = 0}) {
    final String title = json['title'] ?? 'Product ${index + 1}';
    final String description = json['description'] ?? 'No description';
    final double price = (json['price'] ?? 0).toDouble();
    final double rating = (json['rating'] ?? 0).toDouble();
    final double discountPercent = (json['discountPercentage'] ?? 0).toDouble();
    final String brand = json['brand'] ?? 'Generic';
    final String category = json['category'] ?? 'beauty';

    final bool isFeatured = rating >= 4.5;
    final bool isUrgent = discountPercent > 15;
    final double? discount = discountPercent > 0 ? discountPercent : null;

    return ProductEntity(
      id: json['id'].toString(),
      name: title,
      description: description,
      price: price,
      category: _mapCategory(category, index),
      imageUrl: json['thumbnail'] ?? (json['images']?[0] ?? ''),
      color: '#808080', 
      isFeatured: isFeatured,
      isUrgent: isUrgent,
      brand: brand,
      discount: discount,
    );
  }

  static ProductCategory _mapCategory(String category, int index) {
    final cat = category.toLowerCase();
    if (cat.contains('makeup') || cat.contains('beauty')) return ProductCategory.makeup;
    if (cat.contains('skincare') || cat.contains('skin')) return ProductCategory.skincare;
    if (cat.contains('fragrance') || cat.contains('perfume')) return ProductCategory.fragrance;
    if (cat.contains('hair')) return ProductCategory.hair;
    if (cat.contains('tools') || cat.contains('brush')) return ProductCategory.tools;
    if (cat.contains('bath') || cat.contains('body')) return ProductCategory.bathBody;
    final categories = [
      ProductCategory.makeup,
      ProductCategory.skincare,
      ProductCategory.fragrance,
      ProductCategory.hair,
      ProductCategory.tools,
      ProductCategory.bathBody,
    ];
    return categories[index % categories.length];
  }
}