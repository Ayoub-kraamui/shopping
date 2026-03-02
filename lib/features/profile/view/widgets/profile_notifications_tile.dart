import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/constant/colors.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';

/// صف تفعيل/تعطيل الإشعارات
class ProfileNotificationsTile extends StatelessWidget {
  final bool notificationsEnabled;

  const ProfileNotificationsTile({
    super.key,
    required this.notificationsEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primaryGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'الإشعارات',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          Switch(
            value: notificationsEnabled,
            activeThumbColor: AppColors.primaryGreen,
            activeTrackColor: AppColors.primaryGreen.withValues(alpha: 0.4),
            onChanged: (val) {
              context.read<ProfileBloc>().add(ToggleNotifications(val));
            },
          ),
        ],
      ),
    );
  }
}
