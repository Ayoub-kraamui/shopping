abstract class AuthRepository {
  /// تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  Future<bool> loginWithEmail(String email, String password);

  /// إنشاء حساب جديد
  Future<bool> register({
    required String email,
    required String password,
    required String phoneCode,
    required String phoneNumber,
  });

  /// إرسال OTP لرقم الهاتف
  Future<bool> loginWithPhone(String phoneCode, String phoneNumber);

  /// التحقق من حالة تسجيل الدخول
  Future<bool> isLoggedIn();

  /// تسجيل الخروج
  Future<void> logout();
}
