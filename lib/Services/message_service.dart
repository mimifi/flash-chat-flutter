import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;

class MessageService {
  saveMessage(message, email) {
    firestore.collection('messages').add({
      'text': message,
      'sender': email,
    });
  }
}
