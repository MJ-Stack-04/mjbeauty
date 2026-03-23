import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../controllers/home_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final navController = Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () => Container(
            key: ValueKey('home_${controller.refreshToken.value}'),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchBar(productController, navController),
                  const SizedBox(height: 20),
                  _buildPromoBanner(productController, navController),
                  const SizedBox(height: 24),
                  _buildCategoriesSection(navController),
                  const SizedBox(height: 24),
                  _buildUrgentDeals(productController, cartController, navController),
                  const SizedBox(height: 24),
                  _buildBrandProducts(productController, cartController, navController),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(cartController, navController),
    );
  }

  Widget _buildHeader() {
    return AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: const Text(
        'Welcome to MJ Beauty',
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(ProductController productController, NavigationController navController) {
    final searchInput = TextEditingController();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.purple, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                hintText: 'Search for products...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 14),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  searchInput.clear();
                  // Pass the query to search results
                  navController.goToSearchResults(query);
                }
              },
            ),
          ),
          if (searchInput.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.purple, size: 18),
              onPressed: () {
                searchInput.clear();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner(ProductController productController, NavigationController navController) {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (productController.products.isEmpty) {
        return const SizedBox();
      }
      if (productController.products.every((p) => p.discount == null)) {
        return const SizedBox();
      }
      
      final random = Random();
      final promoProduct = productController.products[random.nextInt(productController.products.length)];
      
      return GestureDetector(
        onTap: () => navController.goToProductDetail(promoProduct),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(promoProduct.imageUrl),
              fit: BoxFit.cover,
              onError: (_, _) {},
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Text(
              'Special Offer\n${promoProduct.name}',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCategoriesSection(NavigationController navController) {
    final categories = [
      {'name': 'Makeup', 'icon': Icons.brush, 'color': Colors.pink, 'category': ProductCategory.makeup},
      {'name': 'Skincare', 'icon': Icons.spa, 'color': Colors.blue, 'category': ProductCategory.skincare},
      {'name': 'Fragrance', 'icon': Icons.waves, 'color': Colors.purple, 'category': ProductCategory.fragrance},
      {'name': 'Hair Care', 'icon': Icons.content_cut, 'color': Colors.brown, 'category': ProductCategory.hair},
      {'name': 'Tools', 'icon': Icons.brush, 'color': Colors.orange, 'category': ProductCategory.tools},
      {'name': 'Bath & Body', 'icon': Icons.bathtub, 'color': Colors.teal, 'category': ProductCategory.bathBody},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Categories',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: navController.goToProducts,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text('See All', style: TextStyle(color: Colors.purple, fontSize: 14)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Container(
                width: 70,
                margin: const EdgeInsets.only(right: 12),
                child: CategoryCard(
                  name: cat['name'] as String,
                  icon: cat['icon'] as IconData,
                  color: cat['color'] as Color,
                  category: cat['category'] as ProductCategory,
                  onTap: () => navController.goToCategory(cat['category'] as ProductCategory),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUrgentDeals(ProductController productController, CartController cartController, NavigationController navController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Urgent Deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: navController.goToUrgentDeals,
                child: const Text('See All', style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (productController.products.isEmpty) {
            return const Center(child: Text('No products'));
          }
          
          // Get products with discount
          final urgentProducts = productController.products
              .where((p) => p.discount != null)
              .take(4)
              .toList();
          
          // If no discounted products, take first 4
          final displayProducts = urgentProducts.isNotEmpty ? urgentProducts : productController.products.take(4).toList();
          
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayProducts.length,
              itemBuilder: (context, index) {
                final product = displayProducts[index];
                return SizedBox(
                  width: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      product: product,
                      isUrgent: product.discount != null,
                      maxLines: 2,
                      onTap: () => navController.goToProductDetail(product),
                      onAddToCart: () {
                        cartController.addToCart(product);
                        Get.snackbar('Added', '${product.name} added to cart');
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBrandProducts(ProductController productController, CartController cartController, NavigationController navController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Brand Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: navController.goToBrandProducts,
                child: const Text('See All', style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (productController.products.isEmpty) {
            return const Center(child: Text('No products'));
          }
          
          // Take first 2 products
          final displayProducts = productController.products.take(2).toList();
          
          return Column(
            children: displayProducts.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.purple[100],
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      ),
                    ),
                    title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Ksh${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.purple),
                      onPressed: () {
                        cartController.addToCart(product);
                        Get.snackbar('Added', product.name);
                      },
                    ),
                    onTap: () => navController.goToProductDetail(product),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
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
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),
              Obx(() {
                if (cartController.cartItems.isEmpty) return const SizedBox();
                return Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      cartController.cartItems.length > 9 ? '9+' : cartController.cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ],
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
    );
  }
}