import 'package:flutter/material.dart';
import 'otp_field.dart';

class OtpInputFields extends StatelessWidget {
  final int otpLength;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(String, int) onInput;

  const OtpInputFields({
    super.key,
    required this.otpLength,
    required this.controllers,
    required this.focusNodes,
    required this.onInput,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(otpLength, (index) {
          return OtpField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (v) => onInput(v, index),
          );
        }),
      ),
    );
  }
}
