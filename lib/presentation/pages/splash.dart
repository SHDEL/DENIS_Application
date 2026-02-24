
import 'package:DENIS/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DENIS/presentation/theme/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  
  VoidCallback? get onPressed => () {
    print("Button Pressed");
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              constraints: const BoxConstraints(maxWidth: 450), // กำหนดความกว้างสูงสุดสำหรับหน้าจอใหญ่
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  SvgPicture.asset('assets/image/DenisTextIcon.svg'),
                  const SizedBox(height: 100),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.gradprimary,
                      borderRadius: BorderRadius.circular(28), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
                    ),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        backgroundColor: Colors.transparent,
                         
                      ),
                      onPressed: onPressed,
                      child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                    
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      side: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28), // ปรับตามรูปร่างปุ่มใน Theme ของคุณ
                      ),
                    ),
                    onPressed: onPressed,
                    child: const Text('Continue without Sign Up', 
                      style: TextStyle(
                        color: AppColors.primary, 
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                      )
                    ),
                  ),
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}