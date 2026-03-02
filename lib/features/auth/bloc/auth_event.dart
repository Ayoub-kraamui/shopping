import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
class AuthLoginWithEmailSubmitted extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginWithEmailSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// إنشاء حساب جديد
class AuthRegisterSubmitted extends AuthEvent {
  final String email;
  final String password;
  final String phoneNumber;
  final String phoneCode;

  const AuthRegisterSubmitted({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [email, password, phoneNumber, phoneCode];
}

/// إرسال OTP لرقم الهاتف (لبدء عملية تسجيل الدخول بالهاتف)
class AuthLoginWithPhoneSubmitted extends AuthEvent {
  final String phoneNumber;
  final String phoneCode;

  const AuthLoginWithPhoneSubmitted({
    required this.phoneNumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [phoneNumber, phoneCode];
}

/// تسجيل الخروج
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// إعادة تعيين حالة الخطأ
class AuthErrorReset extends AuthEvent {
  const AuthErrorReset();
}

/// تبديل التاب بين "تسجيل الدخول" و"إنشاء حساب"
class AuthUiTabSwitched extends AuthEvent {
  final bool isLoginTab;

  const AuthUiTabSwitched({required this.isLoginTab});

  @override
  List<Object?> get props => [isLoginTab];
}

/// تبديل ظهور/إخفاء كلمة مرور تسجيل الدخول
class AuthUiPasswordToggled extends AuthEvent {
  const AuthUiPasswordToggled();
}

/// تبديل ظهور/إخفاء كلمة مرور إنشاء الحساب
class AuthUiRegisterPasswordToggled extends AuthEvent {
  const AuthUiRegisterPasswordToggled();
}

/// تحديث رقم الهاتف ورمز الدولة
class AuthUiPhoneUpdated extends AuthEvent {
  final String phoneCode;
  final String phoneNumber;

  const AuthUiPhoneUpdated({
    required this.phoneCode,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneCode, phoneNumber];
}
