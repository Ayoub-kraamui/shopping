import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/verify_phone_bloc.dart';
import '../../bloc/verify_phone_event.dart';
import '../../bloc/verify_phone_state.dart';
import '../../../home/view/screen/home_screen.dart';
import '../widgets/verify_phone_header.dart';
import '../widgets/otp_input_fields.dart';
import '../widgets/resend_otp_section.dart';
import '../widgets/verify_progress_bar.dart';
import '../widgets/submit_otp_button.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phoneCode;
  final String phoneNumber;

  const VerifyPhoneScreen({
    super.key,
    required this.phoneCode,
    required this.phoneNumber,
  });

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  static const int _otpLength = 4;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  String get _otp => _controllers.map((c) => c.text).join();
  bool get _isOtpComplete => _otp.length == _otpLength;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onInput(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_isOtpComplete) {
      _submitOtp();
    }
  }

  void _submitOtp() {
    if (!_isOtpComplete) return;
    FocusScope.of(context).unfocus();
    context.read<VerifyPhoneBloc>().add(VerifyPhoneOtpSubmitted(otp: _otp));
  }

  void _resendOtp() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
    context.read<VerifyPhoneBloc>().add(
      VerifyPhoneResendOtpRequested(
        phoneCode: widget.phoneCode,
        phoneNumber: widget.phoneNumber,
      ),
    );
  }

  void _onAuthStateChanged(BuildContext context, VerifyPhoneState state) {
    if (!mounted) return;

    if (state.isError && state.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red.shade700,
          ),
        );
      context.read<VerifyPhoneBloc>().add(const VerifyPhoneErrorReset());
      for (final c in _controllers) {
        c.clear();
      }
      _focusNodes.first.requestFocus();
      return;
    }

    if (state.status == VerifyPhoneStatus.otpResent) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('تم إعادة إرسال رمز التحقق'),
            backgroundColor: Colors.green,
          ),
        );
      return;
    }

    if (state.isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('توثيق رقم الجوال'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
        listener: _onAuthStateChanged,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      VerifyPhoneHeader(
                        phoneCode: widget.phoneCode,
                        phoneNumber: widget.phoneNumber,
                        otpLength: _otpLength,
                      ),
                      const SizedBox(height: 48),
                      OtpInputFields(
                        otpLength: _otpLength,
                        controllers: _controllers,
                        focusNodes: _focusNodes,
                        onInput: _onInput,
                      ),
                      const SizedBox(height: 40),
                      ResendOtpSection(onResend: _resendOtp),
                      const Spacer(),
                      const VerifyProgressBar(),
                      const SizedBox(height: 24),
                      SubmitOtpButton(onSubmit: _submitOtp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
