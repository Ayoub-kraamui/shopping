import 'package:shared_preferences/shared_preferences.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // ─── مفاتيح SharedPreferences ──────────────────────────────────────
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kSavedEmail = 'saved_email';
  static const _kSavedPassword = 'saved_password';
  static const _kSavedPhone = 'saved_phone';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _sharedPrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final prefs = await _sharedPrefs;
    final savedEmail = prefs.getString(_kSavedEmail);
    final savedPassword = prefs.getString(_kSavedPassword);

    // إذا لم يكن هناك حساب مسجّل بعد
    if (savedEmail == null || savedPassword == null) {
      throw Exception('لا يوجد حساب مسجّل، يرجى إنشاء حساب أولاً');
    }

    if (email.isNotEmpty &&
        password.isNotEmpty &&
        email == savedEmail &&
        password == savedPassword) {
      await prefs.setBool(_kIsLoggedIn, true);
      return true;
    }
    return false;
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String phoneCode,
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
      return false;
    }
    final prefs = await _sharedPrefs;
    await Future.wait([
      prefs.setString(_kSavedEmail, email),
      prefs.setString(_kSavedPassword, password),
      prefs.setString(_kSavedPhone, '$phoneCode$phoneNumber'),
    ]);
    return true;
  }

  @override
  Future<bool> loginWithPhone(String phoneCode, String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return phoneNumber.isNotEmpty;
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await _sharedPrefs;
    return prefs.getBool(_kIsLoggedIn) ?? false;
  }

  @override
  Future<void> logout() async {
    final prefs = await _sharedPrefs;
    await prefs.setBool(_kIsLoggedIn, false);
  }
}
