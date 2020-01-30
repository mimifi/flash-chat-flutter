import 'package:flutter/material.dart';

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
