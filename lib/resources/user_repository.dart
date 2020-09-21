import 'package:MyUnicircle/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MyUnicircle/resources/firebase_methods.dart' as _firebaseRepo;

GlobalKey<ScaffoldState> scaffoldKey;

ValueNotifier<User> currentUser = new ValueNotifier(User());

String serverMessage;

Future<User> login({email, password}) async {
  final String url = '${GlobalConfiguration().getString('base_url')}login.php';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode({'email': email, 'password': password}),
  );
  if (response.statusCode == 200) {
    var success = json.decode(response.body)['success'];
    if (success.toString() == '1') {
      setCurrentUser(response.body);
      currentUser.value = User.fromJSON(json.decode(response.body)['userinfo']);
      print(currentUser.value.firstname);
      print(currentUser.value.lastname);
      print(currentUser.value.accessToken);
    } else {
      var message = json.decode(response.body)['message'];
      print(message);
      serverMessage = message.toString();
    }
  } else {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('An error occured. Please try again'),
    ));
  }
  return currentUser.value;
}

Future<User> register(
    {email, password, phone, username, firstname, lastname}) async {
  final String url =
      '${GlobalConfiguration().getString('base_url')}register.php';
  final client = new http.Client();
  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'phone_number': phone,
        'password': password,
        'first_name': firstname,
        'last_name': lastname
      }),
    );
    if (response.statusCode == 200) {
      var success = json.decode(response.body)['success'];
      if (success.toString() == '1') {
        setCurrentUser(response.body);
        currentUser.value = User.fromJSON(json.decode(response.body)['user']);
        _firebaseRepo.addUserCollection(currentUser);
      }
    } else {
      var message = json.decode(response.body)['message'];
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('$message'),
      ));
    }
  } catch (e) {
    print(e);
  }
  return currentUser.value;
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<User> fetchUserById(String id) async {
  try {
    final String url =
        '${GlobalConfiguration().getString('base_url')}user_detail.php';
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer ${currentUser.value.accessToken}'
      },
      body: json.encode({'friend_id': id}),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJSON(json.decode(response.body)['user']);
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> resetPassword(User user) async {
  final String url =
      '${GlobalConfiguration().getString('base_url')}send_reset_link_email.php';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.accessToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}users/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['userinfo'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['userinfo']));
  }
}
