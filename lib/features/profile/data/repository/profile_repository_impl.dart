import 'package:shared_preferences/shared_preferences.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SharedPreferences _prefs;

  ProfileRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<String?> getEmail() async {
    return _prefs.getString('saved_email');
  }

  @override
  Future<String?> getPhone() async {
    return _prefs.getString('saved_phone');
  }

  @override
  Future<void> logout() async {
    await _prefs.setBool('is_logged_in', false);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return _prefs.getBool('notifications_enabled') ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool isEnabled) async {
    await _prefs.setBool('notifications_enabled', isEnabled);
  }

  @override
  Future<String> getSelectedLanguage() async {
    return _prefs.getString('selected_language') ?? 'العربية';
  }

  @override
  Future<void> setSelectedLanguage(String language) async {
    await _prefs.setString('selected_language', language);
  }
}
