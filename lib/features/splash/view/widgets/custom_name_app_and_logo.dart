import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';

class CustomNameAppAndLogo extends StatelessWidget {
  final IconData icon;
  final String nameApp;
  final String description;

  const CustomNameAppAndLogo({
    super.key,
    required this.icon,
    required this.nameApp,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: Center(
            child: Icon(icon, size: 90, color: AppColors.primaryGreen),
          ),
        ),
        SizedBox(height: 24),
        Text(
          nameApp,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColors.textPrimary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
