import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';
import 'profile_language_tile.dart';
import 'profile_notifications_tile.dart';
import 'profile_nav_tile.dart';

/// كارد الإعدادات (اللغة + الإشعارات + سياسة الخصوصية + المساعدة)
class ProfileSettingsCard extends StatelessWidget {
  final String selectedLanguage;
  final bool notificationsEnabled;

  const ProfileSettingsCard({
    super.key,
    required this.selectedLanguage,
    required this.notificationsEnabled,
  });

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
          //  اللغة
          ProfileLanguageTile(selectedLanguage: selectedLanguage),
          const Divider(color: AppColors.border, height: 1, indent: 56),

          //  الإشعارات
          ProfileNotificationsTile(notificationsEnabled: notificationsEnabled),
          const Divider(color: AppColors.border, height: 1, indent: 56),

          //  سياسة الخصوصية
          ProfileNavTile(
            icon: Icons.privacy_tip_outlined,
            label: 'سياسة الخصوصية',
            onTap: () {},
          ),
          const Divider(color: AppColors.border, height: 1, indent: 56),

          //  المساعدة والدعم
          ProfileNavTile(
            icon: Icons.help_outline,
            label: 'المساعدة والدعم',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
