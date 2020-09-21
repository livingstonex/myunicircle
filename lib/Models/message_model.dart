import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timestamp;
  String photoUrl;

  MessageModel(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp});
  MessageModel.imageMessage(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp,
      this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['sender_id'] = this.senderId;
    map['receiver_id'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['sender_id'] = this.senderId;
    map['receiver_id'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    map['photo_url'] = this.photoUrl;
    return map;
  }

  MessageModel.fromMap(Map<String, dynamic> map) {
    this.senderId = map['sender_id'];
    this.receiverId = map['receiver_id'];
    this.type = map['type'];
    this.message = map['message'];
    this.timestamp = map['timestamp'];
    this.photoUrl = map['photo_url'];
  }
}
