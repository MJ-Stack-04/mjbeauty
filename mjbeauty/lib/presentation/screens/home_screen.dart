import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/controllers/home_controller.dart';
import 'package:mjbeauty/controllers/product_controller.dart';
import 'package:mjbeauty/routes/app_routes.dart';
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
            leading: product.imageurl !=null && product.imageurl!.isNotEmpty
              ? Image.network(product.imageurl!, width: 50, height: 50,)
              : CircleAvatar(child: Text(product.id.toString()),),
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ksh ${product.price}'),
                if (product.category != null)
                Text(product.category!, style: TextStyle(fontSize: 12),),
              ],
            ),


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
