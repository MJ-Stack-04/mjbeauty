import 'package:get/get.dart';
import 'package:mjbeauty/Screen/CartScreen.dart';
import 'package:mjbeauty/Screen/HomeScreen.dart';
import 'package:mjbeauty/Screen/ProductScreen.dart';
import 'package:mjbeauty/Screen/main_screen.dart';
import 'package:mjbeauty/bindings/CartBinding.dart';
import 'package:mjbeauty/bindings/homebindings.dart';
import 'package:mjbeauty/bindings/main_bindings.dart';
import 'package:mjbeauty/bindings/productbinding.dart';
import 'package:mjbeauty/routes/AppRoutes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const MainScreen(),
        binding: MainBinding(),
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
