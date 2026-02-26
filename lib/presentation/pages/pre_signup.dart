
import 'package:DENIS/presentation/pages/signup.dart';
import 'package:DENIS/presentation/widgets/outline_app_button.dart';
import 'package:DENIS/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PreSignupPage extends StatefulWidget {
  const PreSignupPage({super.key});

  @override
  State<PreSignupPage> createState() => _PreSignupPageState();
}

class _PreSignupPageState extends State<PreSignupPage> {

  VoidCallback? get onPressed => () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
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
                  PrimaryAppButton(onPressed: onPressed, text: 'Sign Up'),
                  const SizedBox(height: 12),
                  OutlineAppButton(onPressed: onPressed, text: 'I have an account already')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}