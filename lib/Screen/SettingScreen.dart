import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Utils/utils.dart';

import '../resources/auth_method.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool onTapNameEdit = false;
  bool onTapPasswordEdit = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  String uname = "";

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String getUser() {
    users
        .doc(_authMethods.user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.get('username');
        if (this.mounted)
          setState(() {
            uname = data.toString();
          });
      } else {
      }
    });
    return uname.toUpperCase();
  }

  Future<void> deleteUser() {
    return users.doc(_authMethods.user.uid).delete();
  }

  Future<void> updateUser(String uname) {
    return users
        .doc(_authMethods.user.uid)
        .set(
          {
            'username': uname,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: tintWhite,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: h * 0.01,
                ),
                TextIcon(
                    (getUser().toString().length >= 16)
                        ? getUser().toString().substring(0, 16)
                        : getUser().toString(),
                    Icon(Icons.edit),
                    28),
                SizedBox(
                  height: h * 0.01,
                ),
                if (onTapNameEdit)
                  EditBox("Username", Icon(Icons.person), username),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                TextIcon("Change Password ?", Icon(Icons.edit), 30),
                SizedBox(
                  height: h * 0.01,
                ),
                if (onTapPasswordEdit)
                  EditBox("Email", Icon(Icons.email), email),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: h * 0.01,
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
                  height: h * 0.01,
                ),
                InkWell(
                  onTap: () {
                    deleteUser();
                    AuthMethods().user.delete();
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Container(
                    height: h * 0.065,
                    width: w * 0.85,
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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                color: Colors.black,
                fontSize: fontS,
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: w * 0.02,
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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
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
          height: h * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: h * 0.05,
              width: w * 0.38,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    if (text == "Email") {
                      _authMethods.passwordChange(context, email.text);
                      email.clear();
                      showSnackBar(context,
                          "You will recieve a mail to reset your password.");
                      setState(() {
                        onTapPasswordEdit = false;
                      });
                    } else {
                      updateUser(username.text);
                      username.clear();
                      showSnackBar(context, "Username Updated Successfully");
                      setState(() {
                        onTapNameEdit = false;
                      });
                    }
                  },
                  child: Text((text == "Email") ? "reset" : "save",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
            Container(
              height: h * 0.05,
              width: w * 0.38,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
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
          height: h * 0.01,
        ),
        if (text == "Email")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Want to generate Password?",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
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
