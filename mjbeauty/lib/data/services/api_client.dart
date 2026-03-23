import 'dart:async';

import 'package:get/get.dart';
import 'package:mjbeauty/data/dto/product_Dto.dart';

class ApiClient extends GetConnect{
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const Duration _timeOut = Duration(seconds:5);

  ApiClient () {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = _timeOut;

    httpClient.addRequestModifier<void> ((request) {
      request.headers['Accept'] ='application/json';
      return request;
    });
  }
  Future<List<ProductDto>> getProducts () async {
    try {
      print('Fetching Products');

      final response = await get (
        '/products',
        decoder: (data) {
          if (data is List){
            return ProductDto.fromJsonList(data);
          }
          return <ProductDto>[];
        },
      ).timeout(_timeOut);

      if (response.hasError) {
        print('API error: ${response.statusCode} - ${response.statusText}');
        throw Exception('Failed to Load Products: ${response.statusText}');
    }

      print('Successfully fetched ${response.body?.length ?? 0} products');
      return response.body ?? <ProductDto>[];
  } on TimeoutException {
      print('API request timed out after $_timeOut');
      throw TimeoutException('Request Timed Out after $_timeOut');
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
}
Future<ProductDto> getProductById (int id) async{
  try {
  print('Fetching Product #$id');
  final response = await get(
    '/products/$id',
    decoder: (data) {
      return ProductDto.fromJson(data as Map<String, dynamic>);
    },
  ).timeout(_timeOut);
  if (response.hasError) {
    print('API error for Product #$id: ${response.statusText}');
    throw Exception('Failed to Load Product #$id: ${response.statusText}');
  }
  print('Successfully fetched Product: ${response.body?.title}');
  return response.body!;
  } on TimeoutException {
    print('Product request Timed out for ID: $id');
    throw TimeoutException('Request timed out');
  }
}
}