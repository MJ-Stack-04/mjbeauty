import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/controllers/HomeController.dart';
import 'package:mjbeauty/controllers/ProductController.dart';
import 'package:mjbeauty/routes/AppRoutes.dart';
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MJ Beauty'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Ksh ${product.price}'),
            onTap: () {
              Get.find<ProductController>().setProduct(product);
              Get.toNamed(AppRoutes.product);
            },
          );
        },
      )),
    );
  }
}
