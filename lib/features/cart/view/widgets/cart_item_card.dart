import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/constant/colors.dart';
import 'package:shopping/features/cart/data/model/cart_item_model.dart';
import '../../bloc/cart_bloc.dart';
import 'cart_quantity_button.dart';

/// بطاقة منتج واحد داخل  سلة التسوق
class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // ─── صورة المنتج ──────────────────────────────────────────────
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(item.product.image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 14),

          // ─── معلومات المنتج ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان + زر الحذف
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // السعر
                Text(
                  '${item.product.price} \$',
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),

                // ─── أزرار الكمية ──────────────────────────────────────
                Row(
                  children: [
                    CartQuantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        context.read<CartBloc>().add(CartItemDecremented(item));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    CartQuantityButton(
                      icon: Icons.add,
                      filled: true,
                      onTap: () {
                        context.read<CartBloc>().add(CartItemIncremented(item));
                      },
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      onTap: () {
                        context.read<CartBloc>().add(CartItemRemoved(item));
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
