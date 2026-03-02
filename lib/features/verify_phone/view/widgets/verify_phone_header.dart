import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';

class VerifyPhoneHeader extends StatelessWidget {
  final String phoneCode;
  final String phoneNumber;
  final int otpLength;

  const VerifyPhoneHeader({
    super.key,
    required this.phoneCode,
    required this.phoneNumber,
    required this.otpLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 2),
          ),
          child: const Icon(
            Icons.security,
            color: AppColors.primaryGreen,
            size: 40,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'أدخل رمز التحقق',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'لقد أرسلنا رمز المكون من $otpLength أرقام إلى الرقم\n'
          '$phoneCode $phoneNumber',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
