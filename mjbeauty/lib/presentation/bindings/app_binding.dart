import 'package:get/get.dart';
import 'package:mjbeauty/data/repositories/product_repository_impl.dart';
import 'package:mjbeauty/data/services/api_client.dart';
import 'package:mjbeauty/data/services/dummy_api_client.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';
import 'package:mjbeauty/presentation/controllers/home_controller.dart';
import 'package:mjbeauty/presentation/controllers/navigation_controller.dart';
import 'package:mjbeauty/presentation/controllers/product_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient(), permanent: true);
    Get.put(DummyApiClient(), permanent: true); 
    Get.put(ProductRepositoryImpl(Get.find<ApiClient>()), permanent: true);
    Get.put(ProductController(Get.find<ProductRepositoryImpl>()), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
  }
}