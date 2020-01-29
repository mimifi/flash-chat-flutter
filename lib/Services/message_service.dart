import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;

class MessageService {
  saveMessage(message, email) {
    firestore.collection('messages').add({
      'text': message,
      'sender': email,
    });
  }

  messageStream() async {
    await for (var snapshot in firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        return (message.data);
      }
    }
  }
}
