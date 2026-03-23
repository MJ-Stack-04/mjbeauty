import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';
import 'package:mjbeauty/presentation/controllers/navigation_controller.dart';
import 'package:mjbeauty/presentation/widgets/cart_item_card.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text('Your cart is empty'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: navController.goToProducts,
                  child: const Text('Start Shopping'),
                ),
              ],
            ),
          );
        }
        
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return CartItemCard(
                    cartItem: item,
                    onIncrease: () => controller.increaseQuantity(item.product.id),
                    onDecrease: () => controller.decreaseQuantity(item.product.id),
                    onRemove: () => controller.removeFromCart(item.product.id),
                    onQuantityChange: (newQty) {
                      controller.updateQuantity(item.product.id, newQty);
                    },
                  );
                },
              ),
            ),
            _buildCheckoutSection(controller),
          ],
        );
      }),
      bottomNavigationBar: _buildBottomNavBar(controller, navController),
    );
  }

  Widget _buildCheckoutSection(CartController controller) {
    return Container(
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
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18)),
                Obx(() => Text(
                  'Ksh${controller.totalAmount}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                )),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _checkout(controller),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Checkout', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkout(CartController controller) {
    Get.snackbar('Order Placed', 'Thank you for your purchase!');
    controller.clearCart();
  }

  Widget _buildBottomNavBar(CartController cartController, NavigationController navController) {
    return BottomNavigationBar(
      currentIndex: navController.currentIndex.value,
      onTap: (index) {
        if (index == 0) navController.goToHome();
        else if (index == 1) navController.goToProducts();
        else if (index == 2) navController.goToCart();
        else if (index == 3) navController.goToProfile();
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
    );
  }
}