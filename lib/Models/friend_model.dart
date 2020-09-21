import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  String id;
  Timestamp addedOn;

  FriendModel({this.id, this.addedOn});

  Map toMap(FriendModel friendModel) {
    var data = Map<String, dynamic>();
    data['friend_id'] = friendModel.id;
    data['added_on'] = friendModel.addedOn;
    return data;
  }

  FriendModel.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['friend_id'];
    this.addedOn = mapData['added_on'];
  }
}
