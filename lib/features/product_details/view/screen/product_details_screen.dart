import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/model/product_model.dart';
import '../../bloc/product_details_bloc.dart';
import '../../data/repository/product_details_impl.dart';
import '../../../../core/constant/colors.dart';
import '../widgets/product_image_section.dart';
import '../widgets/product_info_section.dart';
import '../widgets/product_bottom_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc(ProductDetailsRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            ProductImageSection(imageUrl: product.image),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundDark,
                ),
                child: SingleChildScrollView(
                  child: ProductInfoSection(product: product),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: ProductBottomBar(product: product),
      ),
    );
  }
}
