import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/firebase_options.dart';
import 'package:denis/presentation/pages/homepage.dart';
import 'package:denis/presentation/pages/signin.dart';
import 'package:denis/presentation/pages/splash.dart';
import 'package:denis/presentation/theme/app_theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(), 
    providerApple: AppleDebugProvider(), // ใช้ Debug Provider สำหรับ iOS (เฉพาะในโหมด Debug)
  );

  // ---------- เพิ่มการตั้งค่า Emulator ตรงนี้ ----------
  // if (kDebugMode) {
  //   print("Running in Debug Mode: Connecting to Local Emulators");
  //   try {
  //     // ตั้งค่า Host ให้ถูกต้อง (ปกติเป็น localhost, แต่สำหรับ Android Emulator บางทีต้องเป็น 10.0.2.2)
  //     final emulatorHost = !kIsWeb && Platform.isAndroid ? '10.0.2.2' : 'localhost';
      
  //     // // 2. เชื่อมต่อ Firebase Data Connect Emulator (พอร์ตค่าเริ่มต้นปกติคือ 9399)
  //     ExampleConnector.instance.dataConnect.useDataConnectEmulator(emulatorHost, 9399);

  //     FirebaseFunctions.instance.useFunctionsEmulator(emulatorHost, 5001);

  //     // (ถ้าคุณมีใช้ Firestore ร่วมด้วย ก็เพิ่มของ Firestore ลงไป)
  //     // FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
      
  //   } catch (e) {
  //     print('Failed to connect to emulators: $e');
  //   }
  // }

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
      scaffoldMessengerKey: rootScaffoldMessengerKey,
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
                   // โชว์หน้าขาวๆ โหลดหรือ Splash เผื่อไว้ระหว่างกำลังสืบค้น Role
                   print("กำลังรอโหลด Role อยู่...");
                   return const Scaffold(
                      body: SafeArea(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                   );
                }

                String userRole = "USER"; 
                if (roleSnapshot.hasData && roleSnapshot.data?.data?.user != null) {
                   userRole = roleSnapshot.data!.data!.user!.role; 
                }
                print('User role in main: $userRole');

                if (!kIsWeb && userRole == 'ADMIN') {
                  // สั่งทำงานแสดง SnackBar ทันทีที่ Build หน้านี้เสร็จ
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    rootScaffoldMessengerKey!.currentState?.showSnackBar(
                      SnackBar(
                        content: const Text('If you are Staff or Admin please use the Website version.'), // เปลี่ยนข้อความได้
                        backgroundColor: Colors.red,
                        duration: const Duration(milliseconds: 5000),
                        width: 300.0, // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, // Inner padding for SnackBar content.
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    );
                  });
                  
                  // บังคับออกจากระบบทันที
                  FirebaseAuth.instance.signOut();
                  
                  // แสดงหน้าจอรอระหว่างเตะกลับไปหน้า Sign In
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                else {
                  return MyHomePage(title: 'Home', role: userRole, initialPage: 0,);
                }
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


