import 'package:get/get.dart';
import 'package:mjbeauty/Screen/CartScreen.dart';
import 'package:mjbeauty/Screen/HomeScreen.dart';
import 'package:mjbeauty/Screen/ProductScreen.dart';
import 'package:mjbeauty/bindings/CartBinding.dart';
import 'package:mjbeauty/bindings/homebindings.dart';
import 'package:mjbeauty/bindings/productbinding.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: '/',
        page: () => const HomeScreen(),
        binding: HomeBindings(),
    ),
    GetPage(
        name: '/Product',
        page: () => const ProductScreen(),
        binding: ProductBinding(),
    ),
    GetPage(
        name: '/Cart',
        page: () => const CartScreen(),
        binding: CartBinding(),
    )
  ];
}
