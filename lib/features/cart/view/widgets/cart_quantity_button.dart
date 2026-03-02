import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';

/// زر الكمية الدائري (+ أو -)
class CartQuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const CartQuantityButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: filled ? AppColors.primaryGreen : AppColors.backgroundDark,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
