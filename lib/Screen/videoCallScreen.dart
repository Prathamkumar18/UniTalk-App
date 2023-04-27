import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Widgets/options.dart';
import 'package:uni_talk/resources/auth_method.dart';
import 'package:uni_talk/resources/jitsi_meet_methods.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController roomController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  @override
  void initState() {
    super.initState();
    roomController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
  }

  @override
  void dispose() {
    super.dispose();
    roomController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
        roomName: roomController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: tintWhite,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            backgroundColor: tintWhite,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: tintWhite)),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: h * 0.7,
              width: w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Join a Meeting",
                  style: TextStyle(
                      color: black, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: roomController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Room No.";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "1234567890",
                              label: Text(
                                "Room No",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.numbers)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Name";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: _authMethods.user.displayName,
                              label: Text(
                                "UserName",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Options(
                  icon: Icon(
                    Icons.spatial_audio_off,
                    size: 40,
                  ),
                  isMuted: isAudioMuted,
                  onChanged: (val) => audioMuted(val),
                  text: "Mute Audio",
                ),
                Options(
                  icon: Icon(
                    Icons.videocam,
                    size: 40,
                  ),
                  isMuted: isVideoMuted,
                  onChanged: (val) => videoMuted(val),
                  text: "Mute Video",
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: h * 0.055,
                  width: w * 0.6,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => tintWhite),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black)),
                    onPressed: _joinMeeting,
                    child: Text(
                      "Join",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 218, 238, 255)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ));
  }

  videoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  audioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }
}
