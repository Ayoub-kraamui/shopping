import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/auth/view/screen/login_screen.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';
import '../widgets/profile_avatar_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_settings_card.dart';
import '../widgets/profile_logout_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  void _logout() {
    context.read<ProfileBloc>().add(LogoutUser());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  عنوان الصفحة
              const Text(
                'حسابي',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 28),

              //  الصورة الشخصية والاسم
              ProfileAvatarHeader(email: state.email),
              const SizedBox(height: 28),

              //  كارد معلومات المستخدم
              ProfileInfoCard(email: state.email, phone: state.phone),
              const SizedBox(height: 20),

              //  كارد الإعدادات
              ProfileSettingsCard(
                selectedLanguage: state.selectedLanguage,
                notificationsEnabled: state.notificationsEnabled,
              ),
              const SizedBox(height: 28),

              //  زر تسجيل الخروج
              ProfileLogoutButton(onLogout: _logout),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
