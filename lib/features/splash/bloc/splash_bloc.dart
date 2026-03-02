import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      emit(SplashAuthenticated());
    } else {
      final String? savedEmail = prefs.getString('saved_email');

      if (savedEmail == null || savedEmail.isEmpty) {
        emit(SplashUnauthenticated(shouldRegister: true));
      } else {
        emit(SplashUnauthenticated(shouldRegister: false));
      }
    }
  }
}
