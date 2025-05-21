import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String message;
  final String recieverID;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.recieverID,
    required this.senderEmail,
    required this.senderID,
    required this.timestamp
  });

  //convert to Map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'message': message,
      'recieverID': recieverID,
      'timestamp': timestamp
    };
  }

}