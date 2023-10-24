import 'dart:math';
import 'package:flutter/material.dart';
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
          SizedBox(
            height: h,
            width: w,
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
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                height: h * 0.28,
                width: w * 0.88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/meeting.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
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
                    SizedBox(
                      width: 10,
                    ),
                    HomeMeetingButton(
                        icon: Icon(
                          Icons.add_box_rounded,
                          size: 50,
                          color: Color.fromARGB(255, 192, 214, 232),
                        ),
                        text: "Join Meeting",
                        onPressed: () => joinMeeting(context)),
                    SizedBox(
                      width: 10,
                    ),
                    HomeMeetingButton(
                        icon: Icon(
                          Icons.calendar_month,
                          size: 50,
                          color: Color.fromARGB(255, 192, 214, 232),
                        ),
                        text: "Schedule",
                        onPressed: () {
                          Navigator.pushNamed(context, '/schedule');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Center(
                child: Text("Create/Join Meeting with just a click!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
