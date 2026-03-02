import 'package:shared_preferences/shared_preferences.dart';
import 'verify_phone_repository.dart';

class VerifyPhoneRepositoryImpl implements VerifyPhoneRepository {
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kMockOtp = '0000'; // OTP للاختبار

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _sharedPrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (otp == _kMockOtp) {
      final prefs = await _sharedPrefs;
      await prefs.setBool(_kIsLoggedIn, true);
      return true;
    }
    return false;
  }

  @override
  Future<bool> resendOtp(String phoneCode, String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return phoneNumber.isNotEmpty;
  }
}
