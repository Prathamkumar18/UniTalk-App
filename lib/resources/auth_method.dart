import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_talk/Utils/utils.dart';

class AuthMethods {
  //Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      //Google SignIn Authentication.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      //Now check if user is not null and if it is a new user then we have to add it to the database.
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  //Creating User with email and password
  createUserWithEmail(
      BuildContext context, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        if (credential.additionalUserInfo!.isNewUser) {
          int index = user.email.toString().indexOf('@');
          String username = user.email.toString().substring(0, index);
          await _firestore.collection('users').doc(user.uid).set({
            'username': username,
            'uid': user.uid,
            'profilePhoto': user.photoURL
          });
        }
      }
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Registered successfully");
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Login Users
  loginUser(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      showSnackBar(context, "logged in successfully");
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Password Change
  passwordChange(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
