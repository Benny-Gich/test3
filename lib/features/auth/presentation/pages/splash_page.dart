import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static String route = 'SplashRoute';
  static String path = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splash Page')));
  }
}
