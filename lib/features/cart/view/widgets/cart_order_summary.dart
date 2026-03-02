import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';
import 'cart_summary_row.dart';

/// قسم ملخص الطلب (المجموع + الضريبة + التوصيل + الإجمالي + زر الشراء)
class CartOrderSummary extends StatelessWidget {
  final double totalPrice;

  const CartOrderSummary({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final subtotal = totalPrice;
    final tax = subtotal * 0.15;
    final total = subtotal + tax;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        border: Border(top: BorderSide(color: AppColors.border)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // ─── صفوف الملخص
          CartSummaryRow(
            label: 'المجموع الفرعي',
            value: '${subtotal.toStringAsFixed(2)} \$',
          ),
          const SizedBox(height: 10),
          CartSummaryRow(
            label: 'ضريبة القيمة المضافة (١٥٪)',
            value: '${tax.toStringAsFixed(2)} \$',
          ),
          const SizedBox(height: 10),
          const CartSummaryRow(
            label: 'رسوم التوصيل',
            value: 'مجاني',
            valueColor: AppColors.primaryGreen,
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.border),
          const SizedBox(height: 14),

          // ─── الإجمالي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${total.toStringAsFixed(2)} \$',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ─── زر إتمام الشراء
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_checkout, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'إتمام عملية الشراء',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
