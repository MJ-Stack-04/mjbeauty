import 'package:get/get.dart';
import 'package:mjbeauty/model/model.dart';

class HomeController extends GetxController{
  var products = <Product> [].obs;

  @override
  void onInit() {
    products.addAll([
      Product(id: 1, name: 'Lipstick', price: 200),
      Product(id: 2, name: 'Mascara', price: 300),
      Product(id: 3, name: 'Brushes', price: 400),
    ]);
    super.onInit();
  }
}