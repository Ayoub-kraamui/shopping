import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../widgets/auth_widgets.dart';
import '../../../../features/verify_phone/view/screen/verify_phone_screen.dart';
import '../../../home/view/screen/home_screen.dart';
import '../widgets/login/login_header.dart';
import '../widgets/login/login_switcher_tabs.dart';
import '../widgets/login/login_form.dart';
import '../widgets/login/register_form.dart';
import '../widgets/login/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  final bool initialIsLoginTab;
  const LoginScreen({super.key, this.initialIsLoginTab = true});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.initialIsLoginTab) {
      // إذا كان المفترض إظهار التاب الخاص بالتسجيل أولاً
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AuthBloc>().add(
          const AuthUiTabSwitched(isLoginTab: false),
        );
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();

  final _loginEmailFocus = FocusNode();
  final _loginPasswordFocus = FocusNode();
  final _registerEmailFocus = FocusNode();
  final _registerPasswordFocus = FocusNode();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _loginEmailFocus.dispose();
    _loginPasswordFocus.dispose();
    _registerEmailFocus.dispose();
    _registerPasswordFocus.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      AuthLoginWithEmailSubmitted(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text,
      ),
    );
  }

  void _submitRegister() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final ui = context.read<AuthBloc>().state.uiModel;
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      AuthRegisterSubmitted(
        email: _registerEmailController.text.trim(),
        password: _registerPasswordController.text,
        phoneCode: ui.phoneCode,
        phoneNumber: ui.phoneNumber,
      ),
    );
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (!mounted) return;

    if (state.isError && state.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red.shade700,
          ),
        );
      context.read<AuthBloc>().add(const AuthErrorReset());
      return;
    }

    if (state.isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
      return;
    }

    if (state.isOtpSent) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyPhoneScreen(
            phoneNumber: state.phoneNumber ?? '',
            phoneCode: state.phoneCode ?? '',
            email: state.pendingEmail ?? '',
            password: state.pendingPassword ?? '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: BlocListener<AuthBloc, AuthState>(
        // نستمع فقط لتغيّرات حالة الـ Business (status)
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: _onAuthStateChanged,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: BlocBuilder<AuthBloc, AuthState>(
                // نُعيد البناء فقط عند تغيّر الـ uiModel أو isLoading
                buildWhen: (prev, curr) =>
                    prev.uiModel != curr.uiModel ||
                    prev.isLoading != curr.isLoading,
                builder: (context, state) {
                  final ui = state.uiModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      const LoginHeader(),
                      const SizedBox(height: 40),

                      LoginSwitcherTabs(
                        isLoginTab: ui.isLoginTab,
                        onLoginTabTapped: () => context.read<AuthBloc>().add(
                          const AuthUiTabSwitched(isLoginTab: true),
                        ),
                        onRegisterTabTapped: () => context.read<AuthBloc>().add(
                          const AuthUiTabSwitched(isLoginTab: false),
                        ),
                      ),
                      const Divider(color: AppColors.border, height: 1),
                      const SizedBox(height: 32),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: ui.isLoginTab
                            ? LoginForm(
                                key: const ValueKey('login'),
                                emailController: _loginEmailController,
                                passwordController: _loginPasswordController,
                                isPasswordVisible: ui.isPasswordVisible,
                                emailFocus: _loginEmailFocus,
                                passwordFocus: _loginPasswordFocus,
                                onTogglePassword: () => context
                                    .read<AuthBloc>()
                                    .add(const AuthUiPasswordToggled()),
                              )
                            : RegisterForm(
                                key: const ValueKey('register'),
                                emailController: _registerEmailController,
                                passwordController: _registerPasswordController,
                                isPasswordVisible: ui.isRegisterPasswordVisible,
                                emailFocus: _registerEmailFocus,
                                passwordFocus: _registerPasswordFocus,
                                onTogglePassword: () => context
                                    .read<AuthBloc>()
                                    .add(const AuthUiRegisterPasswordToggled()),
                                onPhoneChanged: (code, number) =>
                                    context.read<AuthBloc>().add(
                                      AuthUiPhoneUpdated(
                                        phoneCode: code,
                                        phoneNumber: number,
                                      ),
                                    ),
                              ),
                      ),

                      const SizedBox(height: 32),
                      AuthPrimaryButton(
                        label: ui.isLoginTab ? 'تسجيل الدخول' : 'إنشاء حساب',
                        isLoading: state.isLoading,
                        onPressed: ui.isLoginTab
                            ? _submitLogin
                            : _submitRegister,
                      ),

                      const SizedBox(height: 40),

                      const SocialLoginSection(),
                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
