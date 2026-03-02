import 'package:flutter/material.dart';
import 'package:shopping/core/constant/colors.dart';
import 'package:shopping/core/constant/image_app.dart';

/// قسم الـ Avatar + الاسم + بادج "عضو مميز"
class ProfileAvatarHeader extends StatelessWidget {
  final String email;

  const ProfileAvatarHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final displayName = email.isNotEmpty && email != 'لا يوجد بريد إلكتروني'
        ? email.split('@').first
        : 'المستخدم';

    return Column(
      children: [
        //  Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryGreen, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              ImageApp.avatar,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => const CircleAvatar(
                backgroundColor: AppColors.cardDark,
                child: Icon(Icons.person, color: Colors.white, size: 48),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        //  الاسم المستخرج من البريد
        Text(
          displayName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),

        // ─── بادج "عضو مميز"
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primaryGreen.withValues(alpha: 0.4),
            ),
          ),
          child: const Text(
            'عضو مميز',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
