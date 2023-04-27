import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_talk/Screen/Home_screen.dart';
import 'package:uni_talk/Screen/SignUp_screen.dart';
import 'package:uni_talk/Screen/SplashScreen.dart';
import 'package:uni_talk/Screen/forgotPassword_screen.dart';
import 'package:uni_talk/Screen/login_screen.dart';
import 'package:uni_talk/Screen/videoCallScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniTalk',
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/signUp': (context) => const SignUpScreen(),
          '/forgotPassword': (context) => const ForgotPasswordScreen(),
          '/video-call':(context) => const VideoCallScreen()
        },
        home: SplashScreen());
  }
}
