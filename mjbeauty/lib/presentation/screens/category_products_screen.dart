import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';
import 'package:mjbeauty/presentation/controllers/navigation_controller.dart';
import 'package:mjbeauty/presentation/controllers/product_controller.dart';
import 'package:mjbeauty/presentation/widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final ProductCategory category;
  
  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final navController = Get.find<NavigationController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.filterByCategory(category);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_getCategoryName(category)),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: navController.goToCart,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final categoryProducts = controller.products;

            if (categoryProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category_outlined, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text('No ${_getCategoryName(category)} products found'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => controller.filterByCategory(category),
                      child: const Text('Load Products'),
                    ),
                  ],
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!controller.isLoadingMore.value && 
                    controller.hasMore.value &&
                    scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8) {
                  controller.loadMoreProducts(); 
                }
                return true;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.65,
                ),
                itemCount: categoryProducts.length + (controller.hasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == categoryProducts.length && controller.hasMore.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(color: Colors.purple),
                      ),
                    );
                  }
                  
                  final product = categoryProducts[index];
                  return ProductCard(
                    product: product,
                    maxLines: 2,
                    onTap: () => navController.goToProductDetail(product),
                    onAddToCart: () {
                      cartController.addToCart(product);
                      Get.snackbar('Added', '${product.name} added to cart');
                    },
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }

  String _getCategoryName(ProductCategory category) {
    switch (category) {
      case ProductCategory.makeup: return 'Makeup';
      case ProductCategory.skincare: return 'Skincare';
      case ProductCategory.fragrance: return 'Fragrance';
      case ProductCategory.hair: return 'Hair Care';
      case ProductCategory.tools: return 'Tools';
      case ProductCategory.bathBody: return 'Bath & Body';
    }
  }
}