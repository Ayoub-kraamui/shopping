import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';

/// صف معلومة واحدة (أيقونة + عنوان + قيمة)
class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryGreen, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// كارد معلومات المستخدم (البريد + الهاتف + كلمة المرور)
class ProfileInfoCard extends StatelessWidget {
  final String email;
  final String phone;

  const ProfileInfoCard({super.key, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.email_outlined,
            label: 'البريد الإلكتروني',
            value: email,
          ),
          const Divider(color: AppColors.border, height: 1, indent: 56),
          ProfileInfoTile(
            icon: Icons.phone_outlined,
            label: 'رقم الهاتف',
            value: phone,
          ),
          const Divider(color: AppColors.border, height: 1, indent: 56),
          const ProfileInfoTile(
            icon: Icons.lock_outline,
            label: 'كلمة المرور',
            value: '••••••••',
          ),
        ],
      ),
    );
  }
}
