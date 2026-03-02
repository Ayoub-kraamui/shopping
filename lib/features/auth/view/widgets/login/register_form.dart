import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../core/constant/colors.dart';
import '../auth_widgets.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final VoidCallback onTogglePassword;
  final void Function(String code, String number) onPhoneChanged;

  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.emailFocus,
    required this.passwordFocus,
    required this.onTogglePassword,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextField(
          label: 'البريد الإلكتروني',
          hint: 'example@mail.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocus,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => passwordFocus.requestFocus(),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'أدخل البريد الإلكتروني';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
              return 'صيغة البريد الإلكتروني غير صحيحة';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        AuthTextField(
          label: 'كلمة المرور',
          hint: '••••••••',
          controller: passwordController,
          isPassword: !isPasswordVisible,
          focusNode: passwordFocus,
          textInputAction: TextInputAction.next,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.textSecondary,
            ),
            onPressed: onTogglePassword,
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'أدخل كلمة المرور';
            if (v.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
            return null;
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'رقم الجوال',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            decoration: const InputDecoration(hintText: '5X XXX XXXX'),
            initialCountryCode: 'SA',
            style: const TextStyle(color: Colors.white),
            dropdownTextStyle: const TextStyle(color: Colors.white),
            onChanged: (phone) =>
                onPhoneChanged(phone.countryCode, phone.number),
          ),
        ),
      ],
    );
  }
}
