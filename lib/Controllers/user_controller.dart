import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:MyUnicircle/Views/Login/login_screen2.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:MyUnicircle/Views/Homepage/home.dart';
import 'package:MyUnicircle/Views/Signup/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import '../resources/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  GlobalKey<ScaffoldState> scaffoldKey;

  UserController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> login({email, password}) async {
    // loadingDialog();
    repository.login(email: email, password: password).then((value) {
      //print(value.apiToken);
      if (value != null && value.id != null) {
        Navigator.pop(scaffoldKey.currentContext);
        Navigator.of(scaffoldKey.currentContext)
            .pushNamedAndRemoveUntil('/NewsFeed', (route) => false);
      } else {
         Future.delayed(Duration(seconds: 4), (){
              scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('${repository.serverMessage}'),
              ));
        });
        
      }
    });
  }

  void uploadImage(File file) async {
    loadingDialog();
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    final String url =
        '${GlobalConfiguration().getString('base_url')}uploadprofile.php';

    Dio dio = new Dio();
    dio
        .post(url,
            options: Options(headers: {
              'Authorization':
                  'Bearer ${repository.currentUser.value.accessToken}'
            }),
            data: data)
        .then((response) {
      Navigator.pop(scaffoldKey.currentContext);
      setState(() {});
      print(response);
    }).catchError((error) {
      Navigator.pop(scaffoldKey.currentContext);
      print(error);
    });
  }

  dynamic loadingDialog() {
    return showDialog(
        barrierDismissible: false,
        context: scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                backgroundColor: Colors.black54,
                children: [
                  Center(
                      child: Column(children: [
                    CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white)),
                    SizedBox(height: 10),
                    Text('Please wait...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ))
                  ]))
                ],
              ));
        });
  }

  Future<void> register(
      {email, password, phone, username, firstname, lastname}) async {
    loadingDialog();
    repository
        .register(
            email: email,
            password: password,
            phone: phone,
            username: username,
            firstname: firstname,
            lastname: lastname)
        .then((value) {
      if (value != null || value.id != null) {
        Navigator.pop(scaffoldKey.currentContext);
        showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                content: Text(
                    'You have registered successfully! Welcome to MyUnicircle $firstname $lastname',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(scaffoldKey.currentContext)
                            .pushReplacementNamed('/Login');
                      },
                      child: Text('Proceed to login',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold)))
                ],
              );
            });
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('An error occured. Please try again'),
        ));
      }
    });
  }

  void resetPassword() {
    repository.resetPassword(user).then((value) {
      if (value != null && value == true) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('A reset link has been sent to your email'),
          action: SnackBarAction(
            label: 'Login',
            onPressed: () {
              Navigator.of(scaffoldKey.currentContext)
                  .pushReplacementNamed('/Login');
            },
          ),
          duration: Duration(seconds: 10),
        ));
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error verifying email settings'),
        ));
      }
    });
  }

  Future<void> verifyEmail(
      {email, password, username, phone, firstname, lastname}) async {
    final String url =
        '${GlobalConfiguration().getString('base_url')}email_auth.php';
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'email': email}),
    );
    if (response.statusCode == 200) {
      var success = json.decode(response.body)['success'];
      var code = json.decode(response.body)['code'];

      try {
        if (success.toString() == '1') {
          print(code);
          Navigator.of(scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (context) => VerificationScreen(
                  firstname: firstname,
                  lastname: lastname,
                  number: phone,
                  code: code.toString(),
                  email: email,
                  password: password,
                  username: username)));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Unable to retrieve code. Please try again'),
          ));
        }
      } catch (e) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('An error occured. Please try again'),
        ));
        print(e);
      }
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('An error occured. Please try again'),
      ));
    }
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
