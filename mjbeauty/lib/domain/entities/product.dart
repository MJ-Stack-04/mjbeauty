class Product {
  final int id;
  final String name;
  final double price;
  final String? description;
  final String? category;
  final String? imageUrl;

  Product ({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.category,
    this.imageUrl,
});
}