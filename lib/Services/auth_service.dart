import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final bool showSpinner = false;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  String email;
  String password;
  FirebaseUser loggedInUser;

  registerUser(email, password, BuildContext context) async {
    try {
      AuthResult user = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  signInUser(email, password, BuildContext context) async {
    try {
      AuthResult logInUser = await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (logInUser != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  signOut(BuildContext context) async {
    await fireAuth.signOut();
    Navigator.pop(context, WelcomeScreen.id);
  }

  void getCurrentUser() async {
    final user = await fireAuth.currentUser();
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}
