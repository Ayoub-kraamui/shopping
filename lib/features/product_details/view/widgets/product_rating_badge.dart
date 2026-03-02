import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../home/data/model/product_model.dart';

/// شريط التقييم وحالة التوفر
class ProductRatingBadge extends StatelessWidget {
  final ProductModel product;

  const ProductRatingBadge({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: AppColors.primaryGreen, size: 16),
              const SizedBox(width: 4),
              Text(
                '${product.rating.rate} (${product.rating.count} تقييم)',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          '|   متوفر في المخزون',
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
