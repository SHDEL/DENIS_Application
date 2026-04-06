import 'package:denis/data/repositories/auth_repo_impl.dart';
import 'package:denis/data/service/auth_firebase_service.dart';
import 'package:denis/presentation/pages/homepage.dart';
import 'package:denis/presentation/pages/signin.dart';
import 'package:denis/presentation/theme/app_theme.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:denis/presentation/widgets/primary_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  late final AuthRepoImpl _authRepo;

  @override
  void initState() {
    super.initState();
    // 2. กำหนดค่าที่นี่
    _authRepo = AuthRepoImpl();
  }

  Future<void> _handleSignUp() async {
    // Implement your sign-up logic here, e.g., call your authentication service
    // For demonstration, we'll just navigate to the home page after a delay
    
    try {
      final String userId = await _authRepo.signUp(
        _emailCon.text, 
        _passwordCon.text
      );

      if (mounted) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Home', role: 'USER',)
          )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  VoidCallback? get onPressedSignIn => () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
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
                  const SizedBox(height: 24),
                SvgPicture.asset('assets/image/DenisTextIcon.svg', height: 200),
                  const SizedBox(height: 24),
                  Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.lightTheme.primaryColor)),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Username', controller: _usernameCon),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Email', controller: _emailCon),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Password', controller: _passwordCon, isPassword: true),
                  const SizedBox(height: 44),
                  PrimaryAppButton(onPressed: _handleSignUp, text: 'Create Account'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14)),
                      TextButton(onPressed: onPressedSignIn, child: Text('Sign In', style: TextStyle(color: AppTheme.lightTheme.primaryColor, fontSize: 14))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('If you are Staff or Admin please use the'),
                      Text(' Website', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    ],
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