import 'package:mjbeauty/data/dto/dummy_product_dto.dart';
import 'package:mjbeauty/data/dto/product_dto.dart';
import 'package:mjbeauty/data/services/api_client.dart';
import 'package:mjbeauty/data/services/dummy_api_client.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'package:mjbeauty/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient _primaryClient;
  final DummyApiClient _secondaryClient;

  ProductRepositoryImpl(this._primaryClient) : _secondaryClient = DummyApiClient();

  @override
  Future<List<ProductEntity>> getProducts({int page = 1}) async {
    try {
      final response = await _primaryClient.getProducts(page: page);
      if (response.containsKey('products') && response['products'] is List && (response['products'] as List).isNotEmpty) {
        final List productsJson = response['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return ProductDTO.fromJson(entry.value, index: entry.key);
        }).toList();
      }
      throw Exception('Primary returned no products');
    } catch (e) {
      try {
        final fallbackResponse = await _secondaryClient.getProducts(page: page);
        final List productsJson = fallbackResponse['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return DummyProductDTO.fromJson(entry.value, index: entry.key);
        }).toList();
      } catch (e2) {
        return [];
      }
    }
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(ProductCategory category, {int page = 1}) async {
    String categoryTerm = '';
    switch (category) {
      case ProductCategory.makeup:
        categoryTerm = 'makeup';
        break;
      case ProductCategory.skincare:
        categoryTerm = 'skincare';
        break;
      case ProductCategory.fragrance:
        categoryTerm = 'fragrance';
        break;
      case ProductCategory.hair:
        categoryTerm = 'hair';
        break;
      case ProductCategory.tools:
        categoryTerm = 'brush OR tool';
        break;
      case ProductCategory.bathBody:
        categoryTerm = 'bath OR body';
        break;
    }

    try {
      final response = await _primaryClient.searchProducts(categoryTerm, page: page);
      if (response.containsKey('products') && response['products'] is List && (response['products'] as List).isNotEmpty) {
        final List productsJson = response['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return ProductDTO.fromJson(entry.value, index: entry.key + (page * 100));
        }).toList();
      }
      throw Exception('Primary returned no products');
    } catch (e) {
      try {
        final fallbackResponse = await _secondaryClient.searchProducts(categoryTerm, page: page);
        final List productsJson = fallbackResponse['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return DummyProductDTO.fromJson(entry.value, index: entry.key + (page * 100));
        }).toList();
      } catch (e2) {
        return [];
      }
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query, {int page = 1}) async {
    try {
      final response = await _primaryClient.searchProducts(query, page: page);
      if (response.containsKey('products') && response['products'] is List && (response['products'] as List).isNotEmpty) {
        final List productsJson = response['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return ProductDTO.fromJson(entry.value, index: entry.key + (page * 100));
        }).toList();
      }
      throw Exception('Primary search returned no products');
    } catch (e) {
      try {
        final fallbackResponse = await _secondaryClient.searchProducts(query, page: page);
        final List productsJson = fallbackResponse['products'] ?? [];
        return productsJson.asMap().entries.map((entry) {
          return DummyProductDTO.fromJson(entry.value, index: entry.key + (page * 100));
        }).toList();
      } catch (e2) {
        return [];
      }
    }
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    try {
      final response = await _primaryClient.getProduct(id);
      if (response.containsKey('product') && response['product'] != null) {
        return ProductDTO.fromJson(response['product'], index: 0);
      }
      throw Exception('Primary product not found');
    } catch (e) {
      try {
        final fallbackResponse = await _secondaryClient.getProductById(id);
        if (fallbackResponse.containsKey('id')) {
          return DummyProductDTO.fromJson(fallbackResponse, index: 0);
        }
        return null;
      } catch (e2) {
        return null;
      }
    }
  }
}