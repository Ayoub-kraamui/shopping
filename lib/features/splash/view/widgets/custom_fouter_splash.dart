import 'package:flutter/material.dart';

class CustomFouterSplash extends StatelessWidget {
  final String title;
  const CustomFouterSplash({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.white.withValues(alpha: .3),
      ),
    );
  }
}
