import 'package:DENIS/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class PrimaryAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const PrimaryAppButton({
    required this.onPressed,
    required this.text,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      onPressed: onPressed, 
      style: GradientElevatedButton.styleFrom(
        backgroundGradient: AppColors.gradprimary,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
        ),
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent

      ),
      child: Text (text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))
    );
  }
}