import 'package:flutter/material.dart';

/// زر تسجيل الخروج
class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileLogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onLogout,
        icon: const Icon(Icons.logout, color: Colors.redAccent),
        label: const Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.redAccent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
