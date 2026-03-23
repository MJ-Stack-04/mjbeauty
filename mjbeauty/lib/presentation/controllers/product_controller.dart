import 'package:get/get.dart';
import 'package:mjbeauty/data/repositories/product_repository_impl.dart';
import 'package:mjbeauty/domain/entities/product.dart';

class ProductController extends GetxController {
  final ProductRepositoryImpl _repository;
  
  ProductController(this._repository);
  
  final products = <ProductEntity>[].obs;
  
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final errorMessage = ''.obs;
  
  final selectedCategory = Rx<ProductCategory?>(null);
  final searchQuery = RxString('');
  
  int _currentPage = 1;
  static const int _pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    products.clear();
    _currentPage = 1;
    
    try {
      List<ProductEntity> newProducts;
      
      if (selectedCategory.value != null) {
        newProducts = await _repository.getProductsByCategory(
          selectedCategory.value!,
          page: _currentPage,
        );
      } else if (searchQuery.value.isNotEmpty) {
        newProducts = await _repository.searchProducts(
          searchQuery.value,
          page: _currentPage,
        );
      } else {
        newProducts = await _repository.getProducts(page: _currentPage);
      }
      
      products.value = newProducts;
      hasMore.value = newProducts.length >= _pageSize;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value) return;
    
    isLoadingMore.value = true;
    _currentPage++;
    
    try {
      List<ProductEntity> newProducts;
      
      if (selectedCategory.value != null) {
        newProducts = await _repository.getProductsByCategory(
          selectedCategory.value!,
          page: _currentPage,
        );
      } else if (searchQuery.value.isNotEmpty) {
        newProducts = await _repository.searchProducts(
          searchQuery.value,
          page: _currentPage,
        );
      } else {
        newProducts = await _repository.getProducts(page: _currentPage);
      }
      
      if (newProducts.isNotEmpty) {
        products.addAll(newProducts);
        hasMore.value = newProducts.length >= _pageSize;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      hasMore.value = false;
    } finally {
      isLoadingMore.value = false;
    }
  }

  void filterByCategory(ProductCategory? category) {
    selectedCategory.value = category;
    searchQuery.value = ''; 
    fetchProducts();
  }

  void search(String query) {
    searchQuery.value = query;
    selectedCategory.value = null; 
    fetchProducts();
  }

  void clearFilters() {
    selectedCategory.value = null;
    searchQuery.value = '';
    fetchProducts();
  }
  
  List<ProductEntity> getByCategory(ProductCategory category) {
    return products.where((p) => p.category == category).toList();
  }
}