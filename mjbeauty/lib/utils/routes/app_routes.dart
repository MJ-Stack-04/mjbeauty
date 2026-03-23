import 'package:mjbeauty/presentation/screens/cart_screen.dart';
import 'package:mjbeauty/presentation/screens/home_screen.dart';
import 'package:mjbeauty/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const home = '/';
  static const product = '/product';
  static const cart = '/cart';
  static const profile = '/profile';
  static const auth = '/splash';
  
  static final routes = {
    home: (context) => const HomeScreen(),
    cart: (context) => const CartScreen(),
    auth: (context) => const SplashScreen(),
  };
}