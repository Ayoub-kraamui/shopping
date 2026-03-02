import 'package:equatable/equatable.dart';

// نموذج حالة واجهة المستخدم لشاشة التحقق من رقم الهاتف
class VerifyPhoneUiModel extends Equatable {
  // عدد أرقام رمز OTP
  final int otpLength;

  const VerifyPhoneUiModel({this.otpLength = 4});

  VerifyPhoneUiModel copyWith({int? otpLength}) {
    return VerifyPhoneUiModel(otpLength: otpLength ?? this.otpLength);
  }

  @override
  List<Object?> get props => [otpLength];

  @override
  String toString() => 'VerifyPhoneUiModel(otpLength: $otpLength)';
}
