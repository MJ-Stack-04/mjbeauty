import 'package:get/get.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'home_controller.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  
  final RxInt currentIndex = 0.obs;
  
  void goToHome() {
    currentIndex.value = 0;
    Get.offAllNamed('/home');
    Future.delayed(const Duration(milliseconds: 50), () {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshHome();
      }
    });
  }
  
  void goToProducts() {
    currentIndex.value = 1;
    Get.toNamed('/products');
  }
  
  void goToCart() {
    currentIndex.value = 2;
    Get.toNamed('/cart');
  }
  
  void goToProfile() {
    currentIndex.value = 3;
    Get.snackbar('Coming Soon', 'Profile coming soon!');
  }
  
  void goToProductDetail(ProductEntity product) {
    Get.toNamed('/product-detail', arguments: product);
  }
  
  void goToUrgentDeals() {
    currentIndex.value = 1;
    Get.toNamed('/products', parameters: {'filter': 'urgent'});
  }
  
  void goToBrandProducts() {
    currentIndex.value = 1;
    Get.toNamed('/products', parameters: {'filter': 'brand'});
  }
  
  void goToSearchResults(String query) {
    if (query.isNotEmpty) {
      currentIndex.value = 1;
      Get.toNamed('/products', parameters: {'search': query});
    }
  }
  
  void goToCategory(ProductCategory category) {
    String routeName;
    switch (category) {
      case ProductCategory.makeup: routeName = '/category/makeup'; break;
      case ProductCategory.skincare: routeName = '/category/skincare'; break;
      case ProductCategory.fragrance: routeName = '/category/fragrance'; break;
      case ProductCategory.hair: routeName = '/category/hair'; break;
      case ProductCategory.tools: routeName = '/category/tools'; break;
      case ProductCategory.bathBody: routeName = '/category/bathbody'; break;
    }
    Get.toNamed(routeName, arguments: category);
  }
}