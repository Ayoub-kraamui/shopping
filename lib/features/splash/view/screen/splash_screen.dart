import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/constant/colors.dart';
//import '../../../features/auth/view/screen/login_screen.dart';
//import '../../../features/home/view/screen/home_screen.dart';
import '../../bloc/splash_bloc.dart';
import '../../bloc/splash_event.dart';
import '../../bloc/splash_state.dart';
import '../widgets/custom_fouter_splash.dart';
import '../widgets/custom_name_app_and_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => const HomeScreen()),
            // );
          } else if (state is SplashUnauthenticated) {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         LoginScreen(initialIsLoginTab: !state.shouldRegister),
            //   ),
            // );
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const CustomNameAppAndLogo(
                    icon: Icons.shopping_cart_outlined,
                    nameApp: 'تطبيق التسوق المتكامل',
                    description: 'استمتع بتجربة تسوق سهله وممتعه',
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                        if (state is SplashLoading) {
                          return LinearProgressIndicator(
                            minHeight: 4,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.primaryBlue,
                            ),
                          );
                        }
                        return SizedBox(height: 4);
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  const CustomFouterSplash(
                    title: 'SECURE ENTERPRISE SOLUTION\nv1.0.0',
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
