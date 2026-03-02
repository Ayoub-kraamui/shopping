import 'package:equatable/equatable.dart';
import '../data/model/login_ui_model.dart';

enum AuthStatus { initial, loading, success, error, otpSent }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final String? phoneNumber;
  final String? phoneCode;

  final LoginUiModel uiModel;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.phoneNumber,
    this.phoneCode,
    this.uiModel = const LoginUiModel(),
  });

  bool get isLoading => status == AuthStatus.loading;
  bool get isSuccess => status == AuthStatus.success;
  bool get isError => status == AuthStatus.error;
  bool get isOtpSent => status == AuthStatus.otpSent;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? phoneNumber,
    String? phoneCode,
    LoginUiModel? uiModel,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: status != null && status != AuthStatus.error
          ? null
          : errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneCode: phoneCode ?? this.phoneCode,
      uiModel: uiModel ?? this.uiModel,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    phoneNumber,
    phoneCode,
    uiModel,
  ];

  @override
  String toString() => 'AuthState(status: $status, uiModel: $uiModel)';
}
