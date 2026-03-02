abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {
  final bool shouldRegister;
  SplashUnauthenticated({this.shouldRegister = false});
}
