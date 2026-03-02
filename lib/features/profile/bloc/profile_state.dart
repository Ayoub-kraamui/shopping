import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String email;
  final String phone;
  final bool notificationsEnabled;
  final String selectedLanguage;
  final String errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.email = '',
    this.phone = '',
    this.notificationsEnabled = true,
    this.selectedLanguage = 'العربية',
    this.errorMessage = '',
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? email,
    String? phone,
    bool? notificationsEnabled,
    String? selectedLanguage,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
    status,
    email,
    phone,
    notificationsEnabled,
    selectedLanguage,
    errorMessage,
  ];
}
