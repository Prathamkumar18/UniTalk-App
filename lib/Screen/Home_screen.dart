import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: bg,
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    showSnackBar(context, "Logged Out successfully");
                    Navigator.pushNamed(context, '/login');
                  }).onError((error, stackTrace) =>
                      showSnackBar(context, error.toString()));
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 30,
                ))
          ],
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: bg)),
    );
  }
}
