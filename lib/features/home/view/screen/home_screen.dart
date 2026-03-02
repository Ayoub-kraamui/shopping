import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';
import '../../../../core/constant/colors.dart';
//import '../../../profile/view/screen/profile_screen.dart';
import '../widgets/home_main_view.dart';
import '../widgets/home_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.bottomNavIndex != current.bottomNavIndex,
          builder: (context, state) {
            return _buildCurrentBody(state.bottomNavIndex);
          },
        ),
      ),
      bottomNavigationBar: const HomeBottomNavWidget(),
    );
  }

  Widget _buildCurrentBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeMainView();
      case 1:
        return const Center(
          child: Text(
            'الأقسام',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'المفضلة',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        );
      // case 3:
      //   return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
