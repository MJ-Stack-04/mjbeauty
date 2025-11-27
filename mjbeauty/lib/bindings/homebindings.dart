import 'package:get/get.dart';
import 'package:mjbeauty/controllers/HomeController.dart';
import 'package:mjbeauty/controllers/ProductController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies () {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProductController> (() => ProductController());
  }
  }