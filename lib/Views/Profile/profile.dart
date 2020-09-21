import 'dart:io';
import 'package:MyUnicircle/Controllers/user_controller.dart';
import 'package:MyUnicircle/components/profile_settings_dialog.dart';
import 'package:MyUnicircle/components/userimage.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StateMVC<Profile> {
  UserController _con;

  _ProfileState() : super(UserController()) {
    _con = controller;
  }
  File imageFile;

  _notifier(String serverRes) {
    _con.scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(serverRes)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              height: 300,
              child: Stack(children: [
                header(),
                Positioned(
                  left: 10,
                  bottom: 1,
                  child: Hero(
                      tag: 'profile',
                      child: UserImage(image: "${currentUser.value.image}")),
                ),
                Positioned(
                  left: 80,
                  bottom: 0,
                  child: editBtn(),
                )
              ])),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: friendBox()),
            ],
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('About Me',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        ProfileSettingsDialog(
                          user: currentUser.value,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('First name',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('${currentUser.value.firstname}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('Last name',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('${currentUser.value.lastname}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.mail_outline, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('Email',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('${currentUser.value.email}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone_android, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('Mobile Number',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('${currentUser.value.phone}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                  ])),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('My Posts',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(),
                  ])),
        ])));
  }

  Widget header() {
    return Stack(children: [
      Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/group1.png'),
                  fit: BoxFit.cover))),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 250,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).accentColor.withOpacity(.3),
      ),
    ]);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      Navigator.of(context).pop();
      return _notifier('No image selected');
    } else {
      setState(() {
        imageFile = picture;
      });
      print(imageFile);
      Navigator.of(context).pop();
      _con.uploadImage(imageFile);
    }
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      Navigator.of(context).pop();
      return _notifier('No image selected');
    } else {
      setState(() {
        imageFile = picture;
      });
      print(imageFile);
      Navigator.of(context).pop();
      _con.uploadImage(imageFile);
    }
  }

  Widget editBtn() {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text('Change Profile Picture',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                  children: <Widget>[
                    SizedBox(height: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                              onPressed: () => _openCamera(context),
                              child: Text('Camera')),
                          SizedBox(height: 5),
                          Divider(),
                          SizedBox(height: 5),
                          FlatButton(
                              onPressed: () => _openGallery(context),
                              child: Text('Gallery'))
                        ]),
                    SizedBox(height: 10),
                  ],
                );
              });
        },
        child: Container(
            height: 30,
            width: 30,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
            child: Center(
                child: Icon(Icons.edit, color: Colors.white, size: 15))));
  }

  Widget friendBox() {
    return Container(
        alignment: Alignment.center,
        height: 80,
        width: MediaQuery.of(context).size.width * 0.50,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Friends'),
                    Text('0',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
              VerticalDivider(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Investments'),
                    Text('0',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ))
                  ])
            ]));
  }
}
