import 'package:denis/data/repositories/auth_repo_impl.dart';
import 'package:denis/presentation/pages/homepage.dart';
import 'package:denis/presentation/pages/signup.dart';
import 'package:denis/presentation/theme/app_theme.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:denis/presentation/widgets/primary_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  late final AuthRepoImpl _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepoImpl();
  }

  VoidCallback? get onPressedSignUp => () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  };

  Future<void> _handleSignIn() async {
    try {
      final result = await _authRepo.signIn(
        _usernameCon.text, 
        _passwordCon.text
      );
      String role = result['role'] ?? 'Unknown';
      print('User signed in with UID: ${result['uid']} and Role: $role');
      
    } catch (e) {
      print(e);
    }
  }

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
                  Text('Sign In', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.lightTheme.primaryColor)),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Username or Email', controller: _usernameCon),
                  const SizedBox(height: 24),
                  PrimaryInput(text: 'Password', controller: _passwordCon),
                  const SizedBox(height: 44),
                  PrimaryAppButton(onPressed: _handleSignIn, text: 'Sign In'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14)),
                      TextButton(onPressed: onPressedSignUp, child: Text('Sign Up', style: TextStyle(color: AppTheme.lightTheme.primaryColor, fontSize: 14))),
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