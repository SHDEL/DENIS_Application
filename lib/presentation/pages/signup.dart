import 'package:DENIS/presentation/pages/homepage.dart';
import 'package:DENIS/presentation/widgets/outline_app_button.dart';
import 'package:DENIS/presentation/widgets/primary_app_button.dart';
import 'package:DENIS/presentation/widgets/primary_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  VoidCallback? get onPressedSignUp => () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')));
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
                  const SizedBox(height: 48),
                  SvgPicture.asset('assets/image/DenisTextIcon.svg'),
                  const SizedBox(height: 80),
                  PrimaryInput(text: 'Username'),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Email'),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Password'),
                  const SizedBox(height: 44),
                  PrimaryAppButton(onPressed: onPressedSignUp, text: 'Create Account'),
                  const SizedBox(height: 24),
                  Text('Already have an account? Sign in', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14)),

                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}