import 'package:flutter/material.dart';
import 'package:mjbeauty/domain/entities/product.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final ProductCategory category;
  
  final VoidCallback onTap;
  
  final double? size;
  
  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.category,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  
      child: Container(
        width: size ?? 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: size ?? 60,
              height: size ?? 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: (size ?? 60) * 0.5,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}