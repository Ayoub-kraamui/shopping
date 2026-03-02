import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';
import 'home_widget.dart';

class HomeProductGridWidget extends StatelessWidget {
  const HomeProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGreen),
          );
        } else if (state.status == HomeStatus.error) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state.status == HomeStatus.success) {
          final filteredProducts = state.filteredProducts;

          if (filteredProducts.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد منتجات في هذا القسم',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCardWidget(product: filteredProducts[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
