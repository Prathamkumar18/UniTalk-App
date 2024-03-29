import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    if (user != null) {
      Timer(const Duration(seconds: 4),
          () => Navigator.pushNamed(context, '/home'));
    } else {
      Timer(const Duration(seconds: 4),
          () => Navigator.pushNamed(context, '/login'));
    }
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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 210, 223, 238),
            Color.fromARGB(142, 15, 83, 180)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            )),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.08,
              ),
              Center(
                child: AnimatedBuilder(
                  child: Container(
                    height: h * 0.18,
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
                height: h * 0.02,
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
                      color: Color.fromARGB(255, 181, 191, 227),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
