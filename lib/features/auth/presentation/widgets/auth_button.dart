// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:test3/core/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(360, 60),
        backgroundColor: AppPallete.gradient1,
        disabledBackgroundColor: AppPallete.gradient1.withOpacity(0.5),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              buttonName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
    );
  }
}
