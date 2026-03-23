import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  final RxInt refreshToken = 0.obs;
  
  final RxList<String> featuredCategories = <String>[
    'Lipstick',
    'Foundation',
    'Mascara',
    'Blush',
  ].obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
  
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
  
  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }
  
  String getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'lipstick':
        return '💄';
      case 'foundation':
        return '🎨';
      case 'mascara':
        return '👁️';
      case 'blush':
        return '🌸';
      default:
        return '✨';
    }
  }
  
  void refreshHome() {
    refreshToken.value++;
  }
}