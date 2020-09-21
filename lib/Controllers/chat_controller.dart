import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../resources/user_repository.dart';
import '../resources/firebase_repository.dart' as _repository;
import '../resources/user_repository.dart' as userRepo;

class ChatController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<User> usersList;

  ChatController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<List<User>> fetchAllUsers() async {
    final String url =
        '${GlobalConfiguration().getString('base_url')}fetch_all_user.php';
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer ${currentUser.value.accessToken}'
      },
    );
    if (response.statusCode == 200) {
      var list = json.decode(response.body)['user'] as List;
      List<User> userList = list.map((i) => User.fromJSON(i)).toList();
      setState(() {
        usersList = userList;
      });
    }
  }

  Future<void> sendMessage({text, receiver}) {
    MessageModel _message = MessageModel(
        senderId: currentUser.value.id,
        receiverId: receiver.id,
        type: 'text',
        message: text,
        timestamp: Timestamp.now());

    _repository.addMessageToDB(_message, currentUser.value, receiver);
  }

  Future<List<User>> searchUser({searchQuery}) async {
    final String url =
        '${GlobalConfiguration().getString('base_url')}search_user.php';
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer ${currentUser.value.accessToken}'
      },
      body: json.encode({'search_query': searchQuery}),
    );
    if (response.statusCode == 200) {
      var list = json.decode(response.body)['user'] as List;
      List<User> userList = list.map((i) => User.fromJSON(i)).toList();
      setState(() {
        usersList = userList;
      });
    }
  }

  Future<User> findUserById(String id) async {
    print('Fetching friend by id');
    return userRepo.fetchUserById(id);
  }
}
