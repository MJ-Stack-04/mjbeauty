import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://world.openbeautyfacts.org/api/v2',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ));

  Future<Map<String, dynamic>> getProducts({int page = 1}) async {  
    try {
      final response = await dio.get(
        '/search.json',
        queryParameters: {
          'page': page, 
          'page_size': 20,
          'json': 1,
        },
      );
      return response.data;
    } catch (e) {
      return {'products': []};
    }
  }

  Future<Map<String, dynamic>> getProduct(String barcode) async {
    try {
      final response = await dio.get('/product/$barcode.json');
      return response.data;
    } catch (e) {
      return {'product': null};
    }
  }

  Future<Map<String, dynamic>> searchProducts(String query, {int page = 1}) async {  
    try {
      final response = await dio.get(
        '/search.json',
        queryParameters: {
          'search_terms': query,
          'page': page,  
          'json': 1,
        },
      );
      return response.data;
    } catch (e) {
      return {'products': []};
    }
  }
}