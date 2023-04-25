import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Utils/utils.dart';
import 'package:uni_talk/Widgets/HomeMeetingButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tintWhite,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: tintWhite,
          centerTitle: true,
          title: Text(
            "Meet & Chat",
            style: TextStyle(
                color: black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
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
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: tintWhite)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        color: black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeMeetingButton(
                      icon: Icon(
                        Icons.videocam,
                        size: 50,
                        color: Color.fromARGB(255, 192, 214, 232),
                      ),
                      text: "New Meeting",
                      onPressed: () {}),
                  HomeMeetingButton(
                      icon: Icon(
                        Icons.add_box_rounded,
                        size: 50,
                        color: Color.fromARGB(255, 192, 214, 232),
                      ),
                      text: "Join Meeting",
                      onPressed: () {}),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text("Create/Join Meeting with just a click!",
                    style: TextStyle(
                        color: black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/meeting.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ]),
          ),
          Container(
            height: 35,
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 200, 218, 220),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          )
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: black,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
            elevation: 10,
            iconSize: 28,
            selectedItemColor: _page == 0
                ? Colors.blue
                : _page == 1
                    ? Colors.green
                    : _page == 2
                        ? Colors.red
                        : Color.fromARGB(255, 33, 243, 226),
            unselectedItemColor: Color.fromARGB(255, 226, 224, 255),
            currentIndex: _page,
            onTap: onPageChanged,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.comment_bank),
                label: "Meet & Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock),
                label: "Meetings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help_center),
                label: "Help",
              ),
            ]),
      ),
    );
  }
}
