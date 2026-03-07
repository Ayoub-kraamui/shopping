import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState()) {
    on<AuthLoginWithEmailSubmitted>(_onLoginWithEmail);
    on<AuthRegisterSubmitted>(_onRegister);
    on<AuthLoginWithPhoneSubmitted>(_onLoginWithPhone);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthErrorReset>(_onErrorReset);

    on<AuthUiTabSwitched>(_onUiTabSwitched);
    on<AuthUiPasswordToggled>(_onUiPasswordToggled);
    on<AuthUiRegisterPasswordToggled>(_onUiRegisterPasswordToggled);
    on<AuthUiPhoneUpdated>(_onUiPhoneUpdated);
  }

  Future<void> _onLoginWithEmail(
    AuthLoginWithEmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final success = await _authRepository.loginWithEmail(
        event.email,
        event.password,
      );
      emit(
        success
            ? state.copyWith(status: AuthStatus.success)
            : state.copyWith(
                status: AuthStatus.error,
                errorMessage: 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
              ),
      );
    } catch (e) {
      final message = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      emit(state.copyWith(status: AuthStatus.error, errorMessage: message));
    }
  }

  Future<void> _onRegister(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (event.phoneNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'الرجاء إدخال رقم الجوال',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final otpSent = await _authRepository.loginWithPhone(
        event.phoneCode,
        event.phoneNumber,
      );
      emit(
        otpSent
            ? state.copyWith(
                status: AuthStatus.otpSent,
                phoneNumber: event.phoneNumber,
                phoneCode: event.phoneCode,
                // ← حفظ البيانات مؤقتاً حتى يتم التحقق من الهاتف
                pendingEmail: event.email,
                pendingPassword: event.password,
              )
            : state.copyWith(
                status: AuthStatus.error,
                errorMessage: 'فشل إرسال رمز التحقق',
              ),
      );
    } catch (e) {
      final message = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      emit(state.copyWith(status: AuthStatus.error, errorMessage: message));
    }
  }

  Future<void> _onLoginWithPhone(
    AuthLoginWithPhoneSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final success = await _authRepository.loginWithPhone(
        event.phoneNumber,
        event.phoneCode,
      );
      emit(
        success
            ? state.copyWith(
                status: AuthStatus.otpSent,
                phoneNumber: event.phoneNumber,
                phoneCode: event.phoneCode,
              )
            : state.copyWith(
                status: AuthStatus.error,
                errorMessage: 'فشل إرسال رمز التحقق، تحقق من رقم الهاتف',
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(const AuthState());
  }

  void _onErrorReset(AuthErrorReset event, Emitter<AuthState> emit) {
    if (state.isError) {
      emit(state.copyWith(status: AuthStatus.initial));
    }
  }

  void _onUiTabSwitched(AuthUiTabSwitched event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        uiModel: state.uiModel.copyWith(isLoginTab: event.isLoginTab),
      ),
    );
  }

  void _onUiPasswordToggled(
    AuthUiPasswordToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        uiModel: state.uiModel.copyWith(
          isPasswordVisible: !state.uiModel.isPasswordVisible,
        ),
      ),
    );
  }

  void _onUiRegisterPasswordToggled(
    AuthUiRegisterPasswordToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        uiModel: state.uiModel.copyWith(
          isRegisterPasswordVisible: !state.uiModel.isRegisterPasswordVisible,
        ),
      ),
    );
  }

  void _onUiPhoneUpdated(AuthUiPhoneUpdated event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        uiModel: state.uiModel.copyWith(
          phoneCode: event.phoneCode,
          phoneNumber: event.phoneNumber,
        ),
      ),
    );
  }
}
