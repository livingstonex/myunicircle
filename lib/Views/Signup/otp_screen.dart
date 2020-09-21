import 'dart:async';

import 'package:MyUnicircle/Controllers/user_controller.dart';
import 'package:MyUnicircle/Views/Login/login_screen2.dart';
import 'package:MyUnicircle/config/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:MyUnicircle/Views/Welcome/components/background.dart';

class VerificationScreen extends StatefulWidget {
  final String number;
  final String username;
  final String email;
  final String password;
  final String code;
  final String firstname;
  final String lastname;

  const VerificationScreen(
      {Key key,
      this.number,
      this.username,
      this.email,
      this.password,
      this.code,
      this.firstname,
      this.lastname})
      : super(key: key);
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends StateMVC<VerificationScreen> {
  UserController _con;

  _VerificationScreenState() : super(UserController()) {
    _con = controller;
  }

  String pinCode;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var absHeight = MediaQuery.of(context).size.height;
    var absWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _con.scaffoldKey,
        body: Container(
          height: size.height,
          width: double.infinity,
          // Here i can use size.width but use double.infinity because both work as a same
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/signup_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.25,
                ),
              ),
              SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: absHeight * 0.20,
                    width: absWidth,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: absHeight * 0.80,
                    width: absWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/onboarding0.png',
                            height: 150),
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10),
                          child: Text(
                              'Please enter the 4 digit pin sent to ${widget.email}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              //margin: EdgeInsets.only(top: 10.0),
                              child: PinEntryTextField(
                                //showFieldAsBox: true,
                                fieldWidth: 30.0,
                                fields: 4,
                                onSubmit: (String pin) {
                                  setState(() {
                                    pinCode = pin;
                                  }); //end showDialog()
                                }, // end onSubmit
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: 'Didn\'t recieve any code?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' Resend',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontFamily: 'Poppins'),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {})
                                    ]),
                              ),
                            )),
                        SizedBox(height: size.height * 0.05),
                        roundedButton(),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }

  Widget roundedButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Styles.mainPurple,
          onPressed: () => register(),
          child: btnText,
        ),
      ),
    );
  }

  register() {
    if (pinCode != null && pinCode == widget.code) {
      _con.register(
          firstname: widget.firstname,
          lastname: widget.lastname,
          email: widget.email,
          password: widget.password,
          username: widget.username,
          phone: widget.number);
    } else {
      _con.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Incorrect verification code'),
      ));
    }
  }

  Widget btnText = Text('Verify',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
}
