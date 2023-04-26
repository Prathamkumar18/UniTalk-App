import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Widgets/HomeMeetingButton.dart';
import 'package:uni_talk/resources/jitsi_meet_methods.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async {
    var random=Random();
    String roomName=(random.nextInt(10000000)+10000000).toString();
    _jitsiMeetMethods.createMeeting(roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      color: black, fontSize: 45, fontWeight: FontWeight.bold),
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
                    onPressed:createNewMeeting),
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
                      color: black, fontSize: 21, fontWeight: FontWeight.bold)),
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
          height: 30,
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 219, 222, 238),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        )
      ],
    );
  }
}
