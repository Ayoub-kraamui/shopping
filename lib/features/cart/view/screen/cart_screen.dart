import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/constant/colors.dart';
import '../../bloc/cart_bloc.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_empty_view.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_order_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const CartAppBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const CartEmptyView();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartItemCard(item: state.items[index]);
                  },
                ),
              ),
              CartOrderSummary(totalPrice: state.totalPrice),
            ],
          );
        },
      ),
    );
  }
}
