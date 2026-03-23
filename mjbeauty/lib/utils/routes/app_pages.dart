import 'package:get/get_navigation/get_navigation.dart';
import 'package:mjbeauty/presentation/screens/home_screen.dart';
import 'package:mjbeauty/utils/routes/app_routes.dart';

class AppPages {
 static const INITIAL = AppRoutes.home; 
  static final routes = [
    GetPage(
      name: AppRoutes.home, page: () => HomeScreen()),
      
  ];  
}