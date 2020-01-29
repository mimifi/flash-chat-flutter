import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Services/auth_service.dart';
import 'package:flash_chat/Services/message_service.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AuthService fireAuth = AuthService();
  String messageText;
  MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    fireAuth.getCurrentUser();
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
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageService.saveMessage(
                        messageText,
                        fireAuth.loggedInUser.email,
                      );
                    },
                    child: Text(
                      'Send test',
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

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          List<MessageBubble> messageBubbles = [];
          final messages = snapshot.data.documents;
          for (var message in messages) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;

  MessageBubble({this.text, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(color: Colors.black54),
          ),
          Material(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
