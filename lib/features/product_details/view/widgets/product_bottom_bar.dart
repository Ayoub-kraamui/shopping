import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../../bloc/product_details_bloc.dart';
import '../../../cart/bloc/cart_bloc.dart';
import '../../../home/data/model/product_model.dart';
import 'product_quantity_counter.dart';

class ProductBottomBar extends StatelessWidget {
  final ProductModel product;

  const ProductBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: AppColors.backgroundDark,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              // ─── عداد الكمية
              ProductQuantityCounter(quantity: state.quantity),
              const SizedBox(width: 16),

              // ─── زر الإضافة للسلة
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: state.status == ProductDetailsStatus.adding
                        ? null
                        : () {
                            context.read<ProductDetailsBloc>().add(
                              AddToCart(product, state.quantity),
                            );
                            context.read<CartBloc>().add(
                              CartItemAdded(product, quantity: state.quantity),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تمت الإضافة للسلة بنجاح'),
                                backgroundColor: AppColors.primaryGreen,
                              ),
                            );
                          },
                    child: state.status == ProductDetailsStatus.adding
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.black),
                              SizedBox(width: 8),
                              Text('أضف إلى السلة'),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
