import 'package:flutter/material.dart';
import '../../../home/data/model/product_model.dart';
import 'product_title_price.dart';
import 'product_rating_badge.dart';
import 'product_description_section.dart';
import 'product_features_section.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── العنوان والسعر
        ProductTitlePrice(product: product),
        const SizedBox(height: 16),

        // ─── التقييم وحالة التوفر
        ProductRatingBadge(product: product),
        const SizedBox(height: 32),

        // ─── الوصف
        ProductDescriptionSection(description: product.description),
        const SizedBox(height: 32),

        // ─── المميزات
        const ProductFeaturesSection(),
        const SizedBox(height: 100),
      ],
    );
  }
}
