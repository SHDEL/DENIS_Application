
import 'package:DENIS/presentation/pages/pre_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState(){
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/image/DenisTextIcon.svg'),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3)); // รอ 3 วินาที
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PreSignupPage())); 
    }
  }
}