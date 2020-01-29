import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final bool showSpinner = false;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  String email;
  String password;

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
}
