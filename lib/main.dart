import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/firebase_options.dart';
import 'package:denis/presentation/pages/homepage.dart';
import 'package:denis/presentation/pages/signin.dart';
import 'package:denis/presentation/pages/splash.dart';
import 'package:denis/presentation/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DENIS App',
      theme: AppTheme.lightTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage(); // โชว์หน้า Splash ไปก่อน
          }

          if (snapshot.hasData) {
            String uid = snapshot.data!.uid;
            return FutureBuilder(
              future: ExampleConnector.instance.getRoleById(id: uid).execute(),
              builder: (context, roleSnapshot) {

                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashPage(); 
                }

                String userRole = "USER";
                
                if (roleSnapshot.hasData && roleSnapshot.data?.data?.user != null) {
                   userRole = roleSnapshot.data!.data!.user!.role; 
                }
                print('User role in main: $userRole');

                return MyHomePage(title: 'Home', role: userRole);
              },
            );
          }
          
          // ถ้าไม่มีผู้ใช้ล็อกอินไว้ 
          return const SignInPage(); // ส่งกลับไปหน้า SignIn
        },
      ),
    );
  }
}


