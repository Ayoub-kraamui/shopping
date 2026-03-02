import 'package:flutter/material.dart';
import '../auth_widgets.dart';

class LoginSwitcherTabs extends StatelessWidget {
  final bool isLoginTab;
  final VoidCallback onLoginTabTapped;
  final VoidCallback onRegisterTabTapped;

  const LoginSwitcherTabs({
    super.key,
    required this.isLoginTab,
    required this.onLoginTabTapped,
    required this.onRegisterTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthTabButton(
          title: 'تسجيل الدخول',
          isActive: isLoginTab,
          onTap: onLoginTabTapped,
        ),
        AuthTabButton(
          title: 'إنشاء حساب',
          isActive: !isLoginTab,
          onTap: onRegisterTabTapped,
        ),
      ],
    );
  }
}
