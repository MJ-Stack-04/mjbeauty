import 'package:get/get.dart';
import 'package:mjbeauty/controllers/CartController.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}