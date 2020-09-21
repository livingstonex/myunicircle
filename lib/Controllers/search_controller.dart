import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../resources/user_repository.dart';

class SearchController extends ControllerMVC {
  User user = new User();
  GlobalKey<ScaffoldState> scaffoldKey;
  List<User> usersList;

  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
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
}
