import 'package:flutter/material.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleMeeting extends StatelessWidget {
  const ScheduleMeeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "ScheduleMeeting",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        backgroundColor: tintWhite,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Want to Schedule meet?",
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () async {
              final url = 'https://meet-hhz2.onrender.com';
              await launch(url,
                  forceSafariVC: true,
                  forceWebView: true,
                  enableJavaScript: true);
            },
            child: Text(
              "click here",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
