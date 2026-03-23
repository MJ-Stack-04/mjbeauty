import 'package:flutter/material.dart';
import 'package:mjbeauty/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final bool showAddButton;
  final int? maxLines;
  final int? flex;
  final String? subtitle;
  final TextAlign? textAlign;
  final bool isUrgent;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    this.showAddButton = true,
    this.maxLines,
    this.flex,
    this.subtitle,
    this.textAlign,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, Error, StackTrace) => Container(
                        color: Colors.purple[100],
                        child: const Icon(Icons.image_not_supported, color: Colors.purple),
                      ),
                    ),
                  ),
                  if (isUrgent)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                        child: const Text('SALE', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                ],
              ),
            ),
            
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: maxLines ?? 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Text(
                      'Ksh${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    
                    if (showAddButton)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onAddToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            minimumSize: const Size(double.infinity, 30),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Add To Cart', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}