import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/presentation/screens/category_products_screen.dart';
import 'package:mjbeauty/presentation/screens/product_detail_screen.dart';
import 'package:mjbeauty/presentation/screens/product_listing_screen.dart';
import 'package:mjbeauty/presentation/screens/splash_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/cart_screen.dart';
import 'presentation/bindings/app_binding.dart';
import 'domain/entities/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MJ Beauty',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialBinding: AppBinding(),
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/products', page: () => ProductListingScreen()),
        GetPage(name: '/cart', page: () => const CartScreen()),
        GetPage(name: '/product-detail', page: () => ProductDetailScreen()),
        GetPage(name: '/category/makeup', page: () => CategoryProductsScreen(category: ProductCategory.makeup)),
        GetPage(name: '/category/skincare', page: () => CategoryProductsScreen(category: ProductCategory.skincare)),
        GetPage(name: '/category/fragrance', page: () => CategoryProductsScreen(category: ProductCategory.fragrance)),
        GetPage(name: '/category/hair', page: () => CategoryProductsScreen(category: ProductCategory.hair)),
        GetPage(name: '/category/tools', page: () => CategoryProductsScreen(category: ProductCategory.tools)),
        GetPage(name: '/category/bathbody', page: () => CategoryProductsScreen(category: ProductCategory.bathBody)),
        GetPage(name: '/splash', page: () => const SplashScreen())
      ],
      initialRoute: '/home',
    );
  }
}