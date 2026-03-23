import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/controllers/product_controller.dart';
import 'package:mjbeauty/controllers/cart_controller.dart';
import 'package:mjbeauty/routes/app_routes.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Detail'),
      ),
      body: Obx(() {
        final product = controller.selectedProduct.value;

        if (product == null) {
          return const Center(
            child: Text('Product not selected'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),

              Text(
                'ksh ${product.price}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);
                  debugPrint('${product.name} added successfully',);
                  Get.toNamed(AppRoutes.cart);
                },
                child: const Text('Add To Cart'),
              ),
            ],
          ),
        );
      }),

    );
  }
}
