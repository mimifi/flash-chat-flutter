import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Services/message_service.dart';
import 'package:flash_chat/Widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final String currentUserEmail;
  MessageStream(this.currentUserEmail);
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
              isMe: currentUserEmail == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
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
