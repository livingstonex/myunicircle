import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../resources/user_repository.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PostController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  PostController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> addPost({body, files}) async {
    loadingDialog();
    FormData formData = FormData.fromMap({
      "title": body,
      "files": MultipartFile.fromFile(files.path, filename: 'fileName')
      /*[
        for (var file in files)
          {await MultipartFile.fromFile(file.path, filename: 'fileName')}
              .toList()
      ],*/
    });
    final String url =
        '${GlobalConfiguration().getString('base_url')}create_post.php';

    Dio dio = new Dio();
    dio
        .post(url,
            options: Options(headers: {
              'Authorization':
                  'Bearer ${userRepo.currentUser.value.accessToken}'
            }),
            data: formData)
        .then((response) {
      print(response);
      Navigator.pop(scaffoldKey.currentContext);
      print(response);
    }).catchError((error) {
      Navigator.pop(scaffoldKey.currentContext);
      print(error);
    });
    /*
      final String url =
          '${GlobalConfiguration().getString('base_url')}create_post.php';
      final client = new http.Client();
      final response = await client.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${userRepo.currentUser.value.accessToken}'
          },f
          body: json.encode({'title': body, 'files': files}));
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(scaffoldKey.currentContext);
        if (json.decode(response.body)['success'].toString() == '1') {
          Navigator.pushReplacementNamed(context, '/Home');
        } else {
          var message = json.decode(response.body)['message'];
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('$message'),
          ));
        }
      }
      */
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
}
