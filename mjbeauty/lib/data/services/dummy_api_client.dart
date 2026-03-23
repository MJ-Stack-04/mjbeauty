import 'package:dio/dio.dart';

class DummyApiClient {
  final Dio dio;

  DummyApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://dummyjson.com',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ));

  Future<Map<String, dynamic>> getProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {
          'limit': limit,
          'skip': (page - 1) * limit,
        },
      );
      return response.data;
    } catch (e) {
      return {'products': []};
    }
  }

  Future<Map<String, dynamic>> searchProducts(String query, {int page = 1}) async {
    try {
      final response = await dio.get(
        '/products/search',
        queryParameters: {'q': query},
      );
      return response.data;
    } catch (e) {
      return {'products': []};
    }
  }

  Future<Map<String, dynamic>> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      return response.data;
    } catch (e) {
      return {};
    }
  }
}