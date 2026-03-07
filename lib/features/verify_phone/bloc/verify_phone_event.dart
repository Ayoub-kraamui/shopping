import 'package:equatable/equatable.dart';

abstract class VerifyPhoneEvent extends Equatable {
  const VerifyPhoneEvent();

  @override
  List<Object?> get props => [];
}

// إرسال رمز OTP للتحقق
class VerifyPhoneOtpSubmitted extends VerifyPhoneEvent {
  final String otp;
  final String email;
  final String password;

  const VerifyPhoneOtpSubmitted({
    required this.otp,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [otp, email, password];
}

// طلب إعادة إرسال رمز OTP
class VerifyPhoneResendOtpRequested extends VerifyPhoneEvent {
  final String phoneCode;
  final String phoneNumber;

  const VerifyPhoneResendOtpRequested({
    required this.phoneCode,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneCode, phoneNumber];
}

// إعادة تعيين حالة الخطأ
class VerifyPhoneErrorReset extends VerifyPhoneEvent {
  const VerifyPhoneErrorReset();
}
