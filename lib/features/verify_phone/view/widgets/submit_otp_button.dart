import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/verify_phone_bloc.dart';
import '../../bloc/verify_phone_state.dart';

class SubmitOtpButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitOtpButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
      buildWhen: (prev, curr) => prev.isLoading != curr.isLoading,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: state.isLoading ? null : onSubmit,
            child: state.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Text('تحقق الآن'),
          ),
        );
      },
    );
  }
}
