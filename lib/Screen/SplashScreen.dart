import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_talk/Utils/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);
  @override
  void initState() {
    super.initState();
    if (user != null)
      Timer(const Duration(seconds: 4),
          () => Navigator.pushNamed(context, '/home'));
    else
      Timer(const Duration(seconds: 4),
          () => Navigator.pushNamed(context, '/login'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: black,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: black)),
      backgroundColor: black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: h * 0.1,
            ),
            Center(
              child: AnimatedBuilder(
                // ignore: sort_child_properties_last
                child: Container(
                  height: h * 0.2,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "Assets/Images/icon.png",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * 3.1459,
                    child: child,
                  );
                },
              ),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            Center(
                child: Image(
              height: h * 0.4,
              width: w * 0.75,
              image: AssetImage("Assets/Images/splashIcon.png"),
            )),
            SizedBox(
              height: h * 0.02,
            ),
            Center(
              child: Text(
                "UniTalk App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 45,
                    color: tintWhite,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
