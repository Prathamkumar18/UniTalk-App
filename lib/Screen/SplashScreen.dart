import 'dart:async';

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
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.pushNamed(context, '/login'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: black,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: black)),
      backgroundColor: black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(height: 60,),
          Center(
            child: AnimatedBuilder(
              // ignore: sort_child_properties_last
              child: Container(
                height: 180,
                width: 180,
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
            height: 60,
          ),
          Center(
              child: Image(
            height: 300,
            width: 350,
            image: AssetImage("Assets/Images/splashIcon.png"),
          )),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "UniTalk App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 45, color: tintWhite, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
