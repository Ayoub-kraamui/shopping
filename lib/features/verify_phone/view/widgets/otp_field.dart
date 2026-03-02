import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
          ),
          filled: false,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
