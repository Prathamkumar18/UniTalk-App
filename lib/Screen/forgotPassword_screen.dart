import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Utils/utils.dart';
import 'package:uni_talk/Widgets/CustomButton.dart';
import 'package:uni_talk/resources/auth_method.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    SystemUiOverlayStyle(statusBarColor: bg);
    return Scaffold(
        backgroundColor: bg,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: h * 0.08,
              ),
              Container(
                  height: h * 0.40,
                  width: w,
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
                    left: 20.0, right: 20.0, top: 20, bottom: 15),
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                height: h * 0.02,
              ),
              Center(
                child: CustomButton(
                  text: "Submit",
                  image: false,
                  textColor: white,
                  color: Colors.blue,
                  onPressed: () {
                    _authMethods.PasswordChange(context, emailController.text);
                    showSnackBar(context,
                        "You will recieve a mail to reset your password.");
                  },
                ),
              ),
            ])));
  }
}
