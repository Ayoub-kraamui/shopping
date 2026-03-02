import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class LogoutUser extends ProfileEvent {}

class ToggleNotifications extends ProfileEvent {
  final bool isEnabled;

  const ToggleNotifications(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}

class ChangeLanguage extends ProfileEvent {
  final String language;

  const ChangeLanguage(this.language);

  @override
  List<Object> get props => [language];
}
