import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';

/// صف ملخص واحد (عنوان + قيمة) مع دعم تلوين القيمة
class CartSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const CartSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(
          value,
          style: TextStyle(color: valueColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
