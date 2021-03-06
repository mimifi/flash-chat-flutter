import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Services/auth_service.dart';
import 'package:flash_chat/Services/message_service.dart';
import 'package:flash_chat/Widgets/message_stream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  AuthService fireAuth = AuthService();
  MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    // fireAuth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await fireAuth.signOut(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(
                future: fireAuth.getCurrentUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<FirebaseUser> snapShot) {
                  if (snapShot.hasData) {
                    return MessageStream(snapShot.data.email);
                  }
                  return Container();
                }
                //MessageStream(fireAuth.loggedInUser),
                ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (messageTextController.text != '') {
                        messageService.saveMessage(
                          messageTextController.text,
                          fireAuth.loggedInUser.email,
                        );
                        messageTextController.clear();
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
