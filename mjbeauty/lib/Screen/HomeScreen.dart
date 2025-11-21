import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/controllers/HomeController.dart';
import 'package:mjbeauty/model/model.dart';

class HomeScreen extends GetView<Homecontroller>{
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        'MJ Beauty',
      ),),
      body: Obx(() => ListView.builder(
          itemCount: controller.products.length,
      itemBuilder: (context, index) {
         final Product = controller.products [index];
         return ListTile(
           title: Text(product.name),
           subtitle: Text('ksh ${product.price}'),
           onTap: () {
             Get.find<ProductController>().setProduct(product);
             Get.toNamed(AppRoutes.product);
           },
         )
      },)),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.cart),
        child: const Icon(Icons.shopping_cart),
    ),
  }
}