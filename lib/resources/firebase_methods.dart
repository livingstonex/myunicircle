import 'dart:io';
import 'package:MyUnicircle/enum/user_state.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:MyUnicircle/Models/friend_model.dart';
import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/constants/strings.dart';
import 'package:MyUnicircle/provider/image_provider.dart';
import 'package:MyUnicircle/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

var fireStore = Firestore();
User user = new User();
StorageReference _storageReference;
final CollectionReference _messageCollection =
    fireStore.collection(MESSAGES_COLLECTION);
final CollectionReference _userCollection =
    fireStore.collection(USERS_COLLECTION);

void addUserCollection(currentUser) {
  user = User(
    id: currentUser.value.id,
    phone: currentUser.value.phone,
    email: currentUser.value.email,
    username: currentUser.value.username,
    image: currentUser.value.image,
    accessToken: currentUser.value.accessToken,
    firstname: currentUser.value.firstname,
    lastname: currentUser.value.lastname,
  );

  fireStore
      .collection(USERS_COLLECTION)
      .document(currentUser.value.id)
      .setData({
    "id": currentUser.value.id,
    "phone": currentUser.value.phone,
    "email": currentUser.value.email,
    "username": currentUser.value.username,
    "image": currentUser.value.image,
    "access_token": currentUser.value.accessToken,
    "firstname": currentUser.value.firstname,
    "lastname": currentUser.value.lastname,
  }).catchError((e) => print('$e'));
}

Future<void> addMessageToDb(
    MessageModel message, User sender, User receiver) async {
  var map = message.toMap();
  await _messageCollection
      .document(message.senderId)
      .collection(message.receiverId)
      .add(map);

  addToFriendsList(senderId: sender.id, receiverId: receiver.id);

  return await _messageCollection
      .document(message.receiverId)
      .collection(message.senderId)
      .add(map);
}

DocumentReference getFriendsDocument({String of, String forFriend}) =>
    _userCollection
        .document(of)
        .collection(FRIENDS_COLLECTION)
        .document(forFriend);

addToFriendsList({senderId, receiverId}) async {
  Timestamp _currentTime = Timestamp.now();
  await addToSendersFriendsList(senderId, receiverId, _currentTime);
  await addToReceiversFriendsList(senderId, receiverId, _currentTime);
}

Future<void> addToSendersFriendsList(
    String senderId, String receiverId, currentTime) async {
  DocumentSnapshot senderSnapshot =
      await getFriendsDocument(of: senderId, forFriend: receiverId).get();
  if (!senderSnapshot.exists) {
    FriendModel receiverFriend =
        FriendModel(id: receiverId, addedOn: currentTime);
    var receiverMap = receiverFriend.toMap(receiverFriend);
    await getFriendsDocument(of: senderId, forFriend: receiverId)
        .setData(receiverMap);
  }
}

Future<void> addToReceiversFriendsList(
    String senderId, String receiverId, currentTime) async {
  DocumentSnapshot receiverSnapshot =
      await getFriendsDocument(of: receiverId, forFriend: senderId).get();
  if (!receiverSnapshot.exists) {
    FriendModel senderFriend = FriendModel(id: senderId, addedOn: currentTime);
    var senderMap = senderFriend.toMap(senderFriend);
    await getFriendsDocument(of: receiverId, forFriend: senderId)
        .setData(senderMap);
  }
}

Future<String> uploadImageToStorage(File image) async {
  try {
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask _storageUploadTask = _storageReference.putFile(image);
    var url = await (await _storageUploadTask.onComplete).ref.getDownloadURL();
    return url;
  } catch (e) {
    print(e);
    return null;
  }
}

void setImageMessage(String url, String receiverId, String senderId) async {
  MessageModel _message;
  _message = MessageModel.imageMessage(
      message: 'MESSAGE',
      receiverId: receiverId,
      senderId: senderId,
      photoUrl: url,
      timestamp: Timestamp.now(),
      type: 'image');

  var map = _message.toImageMap();
  await fireStore
      .collection(MESSAGES_COLLECTION)
      .document(_message.senderId)
      .collection(_message.receiverId)
      .add(map);

  await fireStore
      .collection(MESSAGES_COLLECTION)
      .document(_message.receiverId)
      .collection(_message.senderId)
      .add(map);
}

void uploadImage(File image, String receiverId, String senderId,
    ImageUploadProvider imageUploadProvider) async {
  imageUploadProvider.setToLoading();
  String url = await uploadImageToStorage(image);
  print(url);
  imageUploadProvider.setToIdle();
  setImageMessage(url, receiverId, senderId);
}

Stream<QuerySnapshot> fetchFriendsList({String userId}) {
  print('getting friends list');
  return _userCollection
      .document(currentUser.value.id)
      .collection(FRIENDS_COLLECTION)
      .snapshots();
}

Stream<QuerySnapshot> fetchLastMessageBetween(
        {@required String senderId, @required String receiverId}) =>
    _messageCollection
        .document(senderId)
        .collection(receiverId)
        .orderBy('timestamp')
        .snapshots();

void setUserState({@required String userId, @required UserState userState}) {
  int stateNum = Utils.stateToNum(userState);
  _userCollection.document(userId).updateData({"state": stateNum});
}

Stream<DocumentSnapshot> getUserStream({@required String id}) =>
    _userCollection.document(id).snapshots();
