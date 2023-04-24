import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Widgets/CustomButton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: bg,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: bg)),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/forgotPass.jpg"),
                          fit: BoxFit.cover))),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Forgot",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Password?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Don't worry! It happens. Please enter the\nemail address associated with your account.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 15, bottom: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "eg.xyz1@gmail.com",
                            label: Text(
                              "Email ID",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            prefixIcon: Icon(Icons.alternate_email_outlined)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: CustomButton(
                  text: "Submit",
                  image: false,
                  textColor: white,
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ),
            ])));
  }
}
