import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';
import 'package:mjbeauty/presentation/controllers/navigation_controller.dart';
import 'package:mjbeauty/presentation/controllers/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    
    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'Product not found');
        Get.back();
      });
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    final product = args as ProductEntity;
    final cartController = Get.find<CartController>();
    final productController = Get.find<ProductController>();
    final navController = Get.find<NavigationController>();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.purple,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                const Expanded(
                  child: Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: navController.goToCart,
                ),
              ],
            ),
          ),
        
          Container(
            height: 250,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.purple[100],
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.categoryName,
                      style: TextStyle(color: Colors.purple[700], fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Icon(Icons.star_half, color: Colors.amber, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '(128)',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Ksh ${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 14),
                        SizedBox(width: 4),
                        Text('In Stock', style: TextStyle(color: Colors.green, fontSize: 12)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description.isNotEmpty
                        ? product.description
                        : 'No description available.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildReview(
                    'MJ.',
                    '★★★★★',
                    'Love this product! Works great.',
                  ),
                  _buildReview(
                    'Joan.',
                    '★★★★☆',
                    'Good quality, fast shipping.',
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'You May Also Like',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    final related = productController.products
                        .where((p) => p.category == product.category && p.id != product.id)
                        .take(4)
                        .toList();
                    
                    if (related.isEmpty) return const SizedBox();
                    
                    return SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: related.length,
                        padding: const EdgeInsets.only(right: 16),
                        itemBuilder: (context, index) {
                          final relatedProduct = related[index];
                          return Container(
                            width: 110,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 0 : 8,
                            ),
                            child: _buildRelatedProductCard(relatedProduct, cartController, navController),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Obx(() {
          final isInCart = cartController.cartItems.any(
            (item) => item.product.id == product.id,
          );

          return ElevatedButton(
            onPressed: () {
              if (isInCart) {
                navController.goToCart();
              } else {
                cartController.addToCart(product);
                Get.snackbar('Added to Cart', product.name);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isInCart ? Colors.green : Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              isInCart ? 'Go to Cart' : 'Add to Cart',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRelatedProductCard(
    ProductEntity product,
    CartController cartController,
    NavigationController navController,
  ) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(),
        arguments: product,
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, StackTrace) => Container(
                    color: Colors.purple[100],
                    child: const Icon(Icons.image_not_supported, size: 20),
                  ),
                ),
              ),
            ),
            
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Ksh${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReview(String name, String rating, String comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.purple[100],
            child: Text(name[0], style: const TextStyle(color: Colors.purple, fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(rating, style: const TextStyle(color: Colors.amber, fontSize: 11)),
                const SizedBox(height: 2),
                Text(comment, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}