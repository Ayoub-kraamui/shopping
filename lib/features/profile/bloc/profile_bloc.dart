import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository,
      super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LogoutUser>(_onLogoutUser);
    on<ToggleNotifications>(_onToggleNotifications);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final email = await _profileRepository.getEmail();
      final phone = await _profileRepository.getPhone();
      final notificationsEnabled = await _profileRepository
          .getNotificationsEnabled();
      final selectedLanguage = await _profileRepository.getSelectedLanguage();

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          email: email ?? 'لا يوجد بريد إلكتروني',
          phone: phone ?? 'لا يوجد رقم هاتف',
          notificationsEnabled: notificationsEnabled,
          selectedLanguage: selectedLanguage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _profileRepository.logout();
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onToggleNotifications(
    ToggleNotifications event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _profileRepository.setNotificationsEnabled(event.isEnabled);
      emit(state.copyWith(notificationsEnabled: event.isEnabled));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _profileRepository.setSelectedLanguage(event.language);
      emit(state.copyWith(selectedLanguage: event.language));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
