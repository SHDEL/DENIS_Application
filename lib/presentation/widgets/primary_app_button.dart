import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class PrimaryAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  
  const PrimaryAppButton({
    required this.onPressed,
    required this.text,
    this.padding,
    this.fontSize,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      onPressed: onPressed, 
      style: GradientElevatedButton.styleFrom(
        backgroundGradient: AppColors.gradprimary,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
        ),
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent

      ),
      child: Text (text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: fontSize ?? 18))
    );
  }
}