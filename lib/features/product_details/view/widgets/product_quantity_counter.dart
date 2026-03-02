import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../../bloc/product_details_bloc.dart';

/// عداد الكمية (زر - / العدد / زر +)
class ProductQuantityCounter extends StatelessWidget {
  final int quantity;

  const ProductQuantityCounter({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              context.read<ProductDetailsBloc>().add(DecrementQuantity());
            },
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              context.read<ProductDetailsBloc>().add(IncrementQuantity());
            },
          ),
        ],
      ),
    );
  }
}
