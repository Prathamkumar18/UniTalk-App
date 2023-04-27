import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Widgets/HomeMeetingButton.dart';
import 'package:uni_talk/resources/jitsi_meet_methods.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: h,
            width:w,
            child: Column(children: [
              SizedBox(
                height: h * 0.05,
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
                height: h * 0.03,
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
                      onPressed: createNewMeeting),
                  HomeMeetingButton(
                      icon: Icon(
                        Icons.add_box_rounded,
                        size: 50,
                        color: Color.fromARGB(255, 192, 214, 232),
                      ),
                      text: "Join Meeting",
                      onPressed: () => joinMeeting(context)),
                ],
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Center(
                child: Text("Create/Join Meeting with just a click!",
                    style: TextStyle(
                        color: black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                height: h * 0.25,
                width: w * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/meeting.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
