import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../auth_widgets.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final VoidCallback onTogglePassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.emailFocus,
    required this.passwordFocus,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
          textInputAction: TextInputAction.done,
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
        const SizedBox(height: 12),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(color: AppColors.primaryGreen),
            ),
          ),
        ),
      ],
    );
  }
}
