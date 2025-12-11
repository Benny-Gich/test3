import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static String route = 'SplashRoute';
  static String path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.notes_outlined,
          size: 50,
        ),
      ),
    );
  }
}
