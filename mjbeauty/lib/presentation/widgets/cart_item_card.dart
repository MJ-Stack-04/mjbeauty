import 'package:flutter/material.dart';
import 'package:mjbeauty/domain/entities/product.dart';
import 'package:mjbeauty/presentation/controllers/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  
  final CartItem cartItem;
  
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final Function(int)? onQuantityChange;  
  
  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            
            _buildProductImage(product),
            
            const SizedBox(width: 12),
            
            
            Expanded(
              child: _buildProductDetails(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(ProductEntity product) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(product.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductDetails(ProductEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: onRemove,  
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        
        
        Text(
          product.categoryName,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        
        const SizedBox(height: 8),
        
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuantityControls(),
            Text(
              'Ksh${cartItem.subtotal.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityControls() {
    
    final quantityController = TextEditingController(
      text: cartItem.quantity.toString(),
    );
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          
          IconButton(
            icon: const Icon(Icons.remove, size: 16, color: Colors.purple),
            onPressed: onDecrease,  
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          
         
          SizedBox(
            width: 50,
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              onSubmitted: (value) {
                final newQty = int.tryParse(value);
                if (newQty != null && newQty > 0) {
                  onQuantityChange?.call(newQty);
                } else {
                  
                  quantityController.text = cartItem.quantity.toString();
                }
              },
            ),
          ),
          
          
          IconButton(
            icon: const Icon(Icons.add, size: 16, color: Colors.purple),
            onPressed: onIncrease,  
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}