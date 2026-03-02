import 'package:equatable/equatable.dart';
import '../data/model/verify_phone_ui_model.dart';

enum VerifyPhoneStatus { initial, loading, success, error, otpResent }

class VerifyPhoneState extends Equatable {
  final VerifyPhoneStatus status;
  final String? errorMessage;

  final VerifyPhoneUiModel uiModel;

  const VerifyPhoneState({
    this.status = VerifyPhoneStatus.initial,
    this.errorMessage,
    this.uiModel = const VerifyPhoneUiModel(),
  });

  bool get isLoading => status == VerifyPhoneStatus.loading;
  bool get isSuccess => status == VerifyPhoneStatus.success;
  bool get isError => status == VerifyPhoneStatus.error;
  bool get isOtpResent => status == VerifyPhoneStatus.otpResent;

  VerifyPhoneState copyWith({
    VerifyPhoneStatus? status,
    String? errorMessage,
    VerifyPhoneUiModel? uiModel,
  }) {
    return VerifyPhoneState(
      status: status ?? this.status,
      // مسح رسالة الخطأ تلقائياً عند الانتقال لأي حالة غير خطأ
      errorMessage: status != null && status != VerifyPhoneStatus.error
          ? null
          : errorMessage ?? this.errorMessage,
      uiModel: uiModel ?? this.uiModel,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, uiModel];

  @override
  String toString() => 'VerifyPhoneState(status: $status, uiModel: $uiModel)';
}
