import 'package:get/get.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductBinding());
  }
}