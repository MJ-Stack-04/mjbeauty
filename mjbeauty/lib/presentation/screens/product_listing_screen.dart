import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';
import 'package:mjbeauty/presentation/controllers/navigation_controller.dart';
import 'package:mjbeauty/presentation/controllers/product_controller.dart';
import 'package:mjbeauty/presentation/widgets/product_card.dart';

class ProductListingScreen extends StatelessWidget {
  ProductListingScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  
  final List<ProductCategory> allCategories = [
    ProductCategory.makeup,
    ProductCategory.skincare,
    ProductCategory.fragrance,
    ProductCategory.hair,
    ProductCategory.tools,
    ProductCategory.bathBody,
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final navController = Get.find<NavigationController>();
    
    final filter = Get.parameters['filter'] ?? '';
    final searchQuery = Get.parameters['search'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          searchQuery.isNotEmpty 
              ? 'Search Results'
              : filter == 'urgent' 
                  ? 'Urgent Deals'
                  : filter == 'brand' 
                      ? 'Brand Products'
                      : 'Products'
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: navController.goToCart,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (searchQuery.isNotEmpty) {
          final searchResults = controller.products
              .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
          
          if (searchResults.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No products found for "$searchQuery"',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try searching with different keywords',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Go Back', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Found ${searchResults.length} products for "$searchQuery"',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final product = searchResults[index];
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
              ),
            ],
          );
        }

        if (filter.isNotEmpty) {
          List<ProductEntity> displayProducts = [];
          if (filter == 'urgent') {
            displayProducts = controller.products
                .where((p) => p.discount != null)
                .toList();
          } else if (filter == 'brand') {
            displayProducts = controller.products.take(4).toList();
          }

          if (displayProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('No products found'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text('Go Back', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: displayProducts.length,
            itemBuilder: (context, index) {
              final product = displayProducts[index];
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
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.purple),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            searchController.clear();
                            navController.goToSearchResults(query);
                          }
                        },
                      ),
                    ),
                    if (searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, color: Colors.purple),
                        onPressed: () => searchController.clear(),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: controller.products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No products'),
                          ElevatedButton(
                            onPressed: controller.fetchProducts,
                            child: const Text('Load'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: allCategories.length,
                      itemBuilder: (context, index) {
                        final category = allCategories[index];
                        return _buildCategorySection(
                          category, 
                          controller, 
                          cartController, 
                          navController
                        );
                      },
                    ),
            ),
          ],
        );
      }),
      bottomNavigationBar: _buildBottomNavBar(cartController, navController),
    );
  }

  Widget _buildCategorySection(
    ProductCategory category,
    ProductController controller,
    CartController cartController,
    NavigationController navController,
  ) {
    final categoryProducts = controller.products
        .where((p) => p.category == category)
        .take(5)
        .toList();

    if (categoryProducts.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getCategoryName(category),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => navController.goToCategory(category),
                child: const Text('See All', style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              final product = categoryProducts[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: ProductCard(
                  product: product,
                  maxLines: 2,
                  onTap: () => navController.goToProductDetail(product),
                  onAddToCart: () {
                    cartController.addToCart(product);
                    Get.snackbar('Added', '${product.name} added to cart');
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
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