abstract class VerifyPhoneRepository {
  /// التحقق من رمز OTP وحفظ بيانات الحساب عند النجاح
  Future<bool> verifyOtp(String otp, String email, String password);

  /// إعادة إرسال رمز OTP
  Future<bool> resendOtp(String phoneCode, String phoneNumber);
}
