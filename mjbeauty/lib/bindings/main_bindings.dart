import 'package:get/get.dart';
import 'package:mjbeauty/controllers/CartController.dart';
import 'package:mjbeauty/controllers/HomeController.dart';
import 'package:mjbeauty/controllers/ProductController.dart';
import 'package:mjbeauty/controllers/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies () {
    Get.lazyPut <MainController> (() => MainController());
    Get.lazyPut <HomeController> (() => HomeController());
    Get.lazyPut<ProductController> (()=> ProductController());
    Get.lazyPut<CartController> (() => CartController());
}
}