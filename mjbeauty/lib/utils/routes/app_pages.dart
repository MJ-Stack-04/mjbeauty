import 'package:get/get.dart';
import 'package:mjbeauty/Screen/cart_screen.dart';
import 'package:mjbeauty/Screen/home_screen.dart';
import 'package:mjbeauty/Screen/product_screen.dart';
import 'package:mjbeauty/Screen/main_screen.dart';
import 'package:mjbeauty/bindings/cart_bindings.dart';
import 'package:mjbeauty/bindings/home_bindings.dart';
import 'package:mjbeauty/bindings/main_bindings.dart';
import 'package:mjbeauty/bindings/product_bindings.dart';
import 'package:mjbeauty/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.main,
        page: () => const MainScreen(),
        binding: MainBinding(),
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.product,
        page: () => const ProductScreen(),
        binding: ProductBinding(),
    ),
    GetPage(
        name: AppRoutes.cart,
        page: () => const CartScreen(),
        binding: CartBinding(),
    )
  ];
}
