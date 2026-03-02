abstract class VerifyPhoneRepository {
  // التحقق من رمز OTP
  Future<bool> verifyOtp(String otp);

  // إعادة إرسال رمز OTP
  Future<bool> resendOtp(String phoneCode, String phoneNumber);
}
