import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uni_talk/Screen/Home_screen.dart';
import 'package:uni_talk/Screen/login_screen.dart';
import 'package:uni_talk/resources/auth_method.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniTalk',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen()
        },
        home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return HomeScreen();
            }
            return LoginScreen();
          }),
        ));
  }
}