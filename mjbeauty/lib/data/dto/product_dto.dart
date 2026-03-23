import 'package:mjbeauty/domain/entities/product.dart';

class ProductDTO {
  static ProductEntity fromJson(Map<String, dynamic> json, {int index = 0}) {
    final bool isFeatured = index % 2 == 0;  
    final bool isUrgent = index % 3 == 0;    
    
    final List<String> brands = ['Loreal', 'Maybelline', 'Nivea', 'Dove', 'Garnier', 'MAC', 'Estee Lauder'];
    final String brand = brands[index % brands.length];
    
    final double? discount = isUrgent ? [10, 15, 20, 25, 30][index % 5].toDouble() : null;
    
    return ProductEntity(
      id: json['code'] ?? 'prod_$index',
      name: json['product_name'] ?? 'Product ${index + 1}',
      description: json['ingredients_text'] ?? 'Beautiful beauty product',
      price: 1500.0 + (index * 150), 
      category: _mapCategory(index),
      imageUrl: _getImageUrl(json, index),
      color: _mapColor(index),
      isFeatured: isFeatured,
      isUrgent: isUrgent,
      brand: brand,
      discount: discount,
    );
  }

  static String _getImageUrl(Map<String, dynamic> json, int index) {
    if (json['image_url'] != null && json['image_url'].toString().isNotEmpty) {
      return json['image_url'];
    }
    
    final categories = ['makeup', 'skincare', 'fragrance', 'hair', 'tools', 'bathbody'];
    final category = categories[index % categories.length];
    return 'https://picsum.photos/seed/${category}_$index/300/300';
  }

  static ProductCategory _mapCategory(int index) {
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

  static String _mapColor(int index) {
    final colors = ['#FF0000', '#F5DEB3', '#000000', '#FFC0CB', '#4B0082', '#808080'];
    return colors[index % colors.length];
  }
}