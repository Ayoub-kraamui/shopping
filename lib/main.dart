import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/splash/view/screen/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/verify_phone/data/repository/verify_phone_repository_impl.dart';
import 'features/verify_phone/bloc/verify_phone_bloc.dart';
import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/cart/bloc/cart_bloc.dart';
import 'features/profile/data/repository/profile_repository_impl.dart';
import 'features/profile/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioClient()),
        RepositoryProvider(create: (context) => AuthRepositoryImpl()),
        RepositoryProvider(create: (context) => VerifyPhoneRepositoryImpl()),
        RepositoryProvider(
          create: (context) => HomeRepositoryImpl(
            dioClient: RepositoryProvider.of<DioClient>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepositoryImpl(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepositoryImpl>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              homeRepository: RepositoryProvider.of<HomeRepositoryImpl>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              profileRepository: RepositoryProvider.of<ProfileRepositoryImpl>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => VerifyPhoneBloc(
              verifyPhoneRepository:
                  RepositoryProvider.of<VerifyPhoneRepositoryImpl>(context),
            ),
          ),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: MaterialApp(
          title: 'تسوق',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar', 'SA')],
          locale: const Locale('ar', 'SA'),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
