import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_talk/Utils/Colors.dart';
import 'package:uni_talk/Widgets/CustomButton.dart';
import 'package:uni_talk/resources/auth_method.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.05,
            ),
            Center(
              child: Container(
                  height: h * 0.35,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/Login.jpg"),
                          fit: BoxFit.cover))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text("Login",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "eg.xyz1@gmail.com",
                          label: Text(
                            "Email ID",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          prefixIcon: Icon(Icons.alternate_email_outlined)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (value.length < 6) {
                          return "Password should be >=6";
                        } else {
                          return null;
                        }
                      },
                      obscureText: passwordVisible == true ? false : true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "length should be >=6",
                          label: Text("Password",
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          prefixIcon: Icon(Icons.lock_open),
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              child: Icon(passwordVisible == true
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined))),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: CustomButton(
                text: "Login",
                image: false,
                textColor: white,
                color: Colors.blue,
                onPressed: () {
                  _authMethods.loginUser(
                      context, emailController.text, passwordController.text);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text("OR",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: CustomButton(
                image: true,
                text: "Login with Google",
                color: tintWhite,
                textColor: Colors.grey,
                onPressed: () async {
                  bool res = await _authMethods.signInWithGoogle(context);
                  if (res) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/home');
                  }
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
