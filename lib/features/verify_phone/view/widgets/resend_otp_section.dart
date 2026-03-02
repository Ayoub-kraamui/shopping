import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../../bloc/verify_phone_bloc.dart';
import '../../bloc/verify_phone_state.dart';

class ResendOtpSection extends StatelessWidget {
  final VoidCallback onResend;

  const ResendOtpSection({super.key, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'لم يصلك الرمز؟',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
          buildWhen: (prev, curr) => prev.isLoading != curr.isLoading,
          builder: (context, state) {
            return TextButton(
              onPressed: state.isLoading ? null : onResend,
              child: const Text(
                'إعادة إرسال الرمز',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
