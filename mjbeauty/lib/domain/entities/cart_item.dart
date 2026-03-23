import 'package:mjbeauty/domain/entities/product.dart';

class CartItem {
  final ProductEntity product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  
  double get subtotal => product.price * quantity;
}