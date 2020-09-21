import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import '../resources/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  User user = new User();
  GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void update(User user) async {
    repository.update(user).then((value) {
      setState(() {
        //this.favorite = value;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Profile settings updated successfully!'),
      ));
    });
  }

  void logout() {
    repository.logout().whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/Login',
        (Route<dynamic> route) => false,
      );
    });
  }
}
