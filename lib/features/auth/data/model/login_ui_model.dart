import 'package:equatable/equatable.dart';

class LoginUiModel extends Equatable {
  final bool isLoginTab;
  final bool isPasswordVisible;
  final bool isRegisterPasswordVisible;
  final String phoneCode;
  final String phoneNumber;

  const LoginUiModel({
    this.isLoginTab = true,
    this.isPasswordVisible = false,
    this.isRegisterPasswordVisible = false,
    this.phoneCode = '+966',
    this.phoneNumber = '',
  });

  LoginUiModel copyWith({
    bool? isLoginTab,
    bool? isPasswordVisible,
    bool? isRegisterPasswordVisible,
    String? phoneCode,
    String? phoneNumber,
  }) {
    return LoginUiModel(
      isLoginTab: isLoginTab ?? this.isLoginTab,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRegisterPasswordVisible:
          isRegisterPasswordVisible ?? this.isRegisterPasswordVisible,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
    isLoginTab,
    isPasswordVisible,
    isRegisterPasswordVisible,
    phoneCode,
    phoneNumber,
  ];

  @override
  String toString() =>
      'LoginUiModel('
      'isLoginTab: $isLoginTab, '
      'isPasswordVisible: $isPasswordVisible, '
      'isRegisterPasswordVisible: $isRegisterPasswordVisible, '
      'phoneCode: $phoneCode, '
      'phoneNumber: $phoneNumber)';
}
