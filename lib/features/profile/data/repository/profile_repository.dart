import 'dart:async';

abstract class ProfileRepository {
  Future<String?> getEmail();
  Future<String?> getPhone();
  Future<void> logout();
  Future<bool> getNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool isEnabled);
  Future<String> getSelectedLanguage();
  Future<void> setSelectedLanguage(String language);
}
