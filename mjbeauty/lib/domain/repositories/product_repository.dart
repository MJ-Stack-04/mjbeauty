import 'package:mjbeauty/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({int page = 1});
  Future<List<ProductEntity>> getProductsByCategory(ProductCategory category, {int page = 1});
  Future<List<ProductEntity>> searchProducts(String query, {int page = 1});
  Future<ProductEntity?> getProductById(String id);
}