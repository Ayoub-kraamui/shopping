import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/constant/colors.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';

/// صف اختيار اللغة
class ProfileLanguageTile extends StatelessWidget {
  final String selectedLanguage;

  const ProfileLanguageTile({super.key, required this.selectedLanguage});

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
              Icons.language,
              color: AppColors.primaryGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'اللغة',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              dropdownColor: AppColors.cardDark,
              style: const TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryGreen,
              ),
              onChanged: (value) {
                if (value != null) {
                  context.read<ProfileBloc>().add(ChangeLanguage(value));
                }
              },
              items: const [
                DropdownMenuItem(value: 'العربية', child: Text('العربية')),
                DropdownMenuItem(value: 'English', child: Text('English')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
