import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/verify_phone_repository.dart';
import 'verify_phone_event.dart';
import 'verify_phone_state.dart';

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  final VerifyPhoneRepository _verifyPhoneRepository;

  VerifyPhoneBloc({required VerifyPhoneRepository verifyPhoneRepository})
    : _verifyPhoneRepository = verifyPhoneRepository,
      super(const VerifyPhoneState()) {
    on<VerifyPhoneOtpSubmitted>(_onVerifyOtp);
    on<VerifyPhoneResendOtpRequested>(_onResendOtp);
    on<VerifyPhoneErrorReset>(_onErrorReset);
  }

  Future<void> _onVerifyOtp(
    VerifyPhoneOtpSubmitted event,
    Emitter<VerifyPhoneState> emit,
  ) async {
    emit(state.copyWith(status: VerifyPhoneStatus.loading));
    try {
      final success = await _verifyPhoneRepository.verifyOtp(
        event.otp,
        event.email,
        event.password,
      );
      emit(
        success
            ? state.copyWith(status: VerifyPhoneStatus.success)
            : state.copyWith(
                status: VerifyPhoneStatus.error,
                errorMessage: 'رمز التحقق غير صحيح، حاول مرة أخرى',
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerifyPhoneStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResendOtp(
    VerifyPhoneResendOtpRequested event,
    Emitter<VerifyPhoneState> emit,
  ) async {
    emit(state.copyWith(status: VerifyPhoneStatus.loading));
    try {
      final success = await _verifyPhoneRepository.resendOtp(
        event.phoneCode,
        event.phoneNumber,
      );
      emit(
        success
            ? state.copyWith(status: VerifyPhoneStatus.otpResent)
            : state.copyWith(
                status: VerifyPhoneStatus.error,
                errorMessage: 'فشل إعادة إرسال الرمز',
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VerifyPhoneStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onErrorReset(
    VerifyPhoneErrorReset event,
    Emitter<VerifyPhoneState> emit,
  ) {
    if (state.isError) {
      emit(state.copyWith(status: VerifyPhoneStatus.initial));
    }
  }
}
