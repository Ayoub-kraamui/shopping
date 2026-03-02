import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';

/// بطاقة ميزة واحدة قابلة لإعادة الاستخدام
class ProductFeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProductFeatureCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryGreen),
            const SizedBox(width: 8),
            Flexible(
              child: Text(label, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

/// قسم المميزات الذي يجمع بطاقتي الميزات
class ProductFeaturesSection extends StatelessWidget {
  const ProductFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المميزات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            ProductFeatureCard(icon: Icons.water_drop, label: 'مقاومة للماء'),
            SizedBox(width: 16),
            ProductFeatureCard(
              icon: Icons.battery_charging_full,
              label: 'بطارية ١٠ أيام',
            ),
          ],
        ),
      ],
    );
  }
}
