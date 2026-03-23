enum ProductCategory {
  makeup,
  skincare,
  fragrance,
  hair,
  tools,
  bathBody,
}

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final ProductCategory category;
  final String imageUrl;
  final String color;
  final bool isFeatured;     
  final bool isUrgent;       
  final String brand;        
  final double? discount;    

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.color,
    this.isFeatured = false,
    this.isUrgent = false,
    this.brand = 'Unknown',
    this.discount,
  });

  String get categoryName {
    switch (category) {
      case ProductCategory.makeup:
        return 'Makeup';
      case ProductCategory.skincare:
        return 'Skincare';
      case ProductCategory.fragrance:
        return 'Fragrance';
      case ProductCategory.hair:
        return 'Hair Care';
      case ProductCategory.tools:
        return 'Tools';
      case ProductCategory.bathBody:
        return 'Bath & Body';
    }
  }
  
  double get discountedPrice {
    if (discount == null) return price;
    return price * (1 - (discount! / 100));
  }
  
  String get discountBadge {
    if (discount == null) return '';
    return '${discount!.toStringAsFixed(0)}% OFF';
  }
}