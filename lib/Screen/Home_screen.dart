import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_talk/Screen/SettingScreen.dart';
import 'package:uni_talk/Screen/historyMeetingScreen.dart';
import 'package:uni_talk/Screen/meetingScreen.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Utils/utils.dart';

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

  List<Widget> pages = [
    MeetingScreen(),
    HistoryMeetingScreen(),
    SettingScreen(),
  ];

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
      body: pages[_page],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
            elevation: 0.0,
            iconSize: 28,
            selectedItemColor: Color.fromARGB(255, 214, 237, 255),
            unselectedItemColor: Colors.grey,
            currentIndex: _page,
            onTap: onPageChanged,
            items: const [
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
            ]),
      ),
    );
  }
}
