import 'package:DENIS/presentation/theme/app_colors.dart';
import 'package:DENIS/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class OutlineAppButton extends StatelessWidget {
  
  final VoidCallback? onPressed;
  final String text;
  
  const OutlineAppButton({
    required this.onPressed,
    required this.text,
    super.key
  });
  

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24),
        side: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
        ),
      ),
      onPressed: onPressed,
      child: Text(text, 
        style: const TextStyle(
          color: AppColors.primary, 
          fontWeight: FontWeight.w700,
          fontSize: 18
        )
      ),
    );
  }
}


@Preview(name: 'Outline App Button')
  Widget outlineAppButtonPreview(){
    return OutlineAppButton(
      onPressed: () {}, 
      text: 'Outline Button',
    );
  }

