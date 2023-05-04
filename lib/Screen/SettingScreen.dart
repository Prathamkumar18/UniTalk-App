import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/resources/firestore_methods.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/auth_method.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool onTapNameEdit = false;
  bool onTapPasswordEdit = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FirestoreMethods _firestoreMethods = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tintWhite,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                TextIcon("Pratham", Icon(Icons.edit), 30),
                SizedBox(
                  height: 10,
                ),
                if (onTapNameEdit)
                  EditBox("Username", Icon(Icons.person), username),
                TextIcon("Change Password ?", Icon(Icons.edit), 30),
                SizedBox(
                  height: 10,
                ),
                if (onTapPasswordEdit)
                  EditBox("Password", Icon(Icons.password), password),
                SizedBox(
                  height: 20,
                ),
                Text("Deactivate Account:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                Text(
                    "Once you deactivate your account, there is no going back. Please be certain.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 73, 206, 251)),
                        color: Color.fromARGB(255, 8, 0, 49),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "DeActivate",
                        style: TextStyle(
                            color: Color.fromARGB(255, 227, 111, 103),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget TextIcon(String text, Icon icon, double fontS) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                color: Colors.black,
                fontSize: fontS,
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20,
        ),
        InkWell(
            onTap: () {
              setState(() {
                if (text == "Change Password ?") {
                  onTapPasswordEdit = !onTapPasswordEdit;
                } else
                  onTapNameEdit = !onTapNameEdit;
              });
            },
            child: icon)
      ],
    );
  }

  Widget EditBox(String text, Icon icon, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter $text";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: text,
              label: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              prefixIcon: icon),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              width: 140,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(black)),
                  onPressed: () {},
                  child: Text("save",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
            Container(
              height: 40,
              width: 140,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(black)),
                  onPressed: () {
                    setState(() {
                      if (text == "Username") {
                        onTapNameEdit = false;
                      } else
                        onTapPasswordEdit = false;
                    });
                  },
                  child: Text("cancel",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (text == "Password")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Want to generate Password?",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () async {
                  final url =
                      'https://priyanshu25022002raj.github.io/pass.github.io/';
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
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
