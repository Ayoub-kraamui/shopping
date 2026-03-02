import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../auth_widgets.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'أو سجل الدخول بواسطة',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            AuthSocialButton(label: 'آبل', icon: Icons.apple),
            SizedBox(width: 16),
            AuthSocialButton(label: 'جوجل', icon: Icons.g_mobiledata),
          ],
        ),
      ],
    );
  }
}
