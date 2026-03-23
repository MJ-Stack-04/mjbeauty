import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mjbeauty/domain/entities/product.dart';

class CartItem{
  final ProductEntity product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get subtotal => product.price * quantity;
}

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;

  int get cartCount => cartItems.length;
  
  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  void addToCart(ProductEntity product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    
    cartItems.refresh();
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  void increaseQuantity(String productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(String productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  void updateQuantity(String productId, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}