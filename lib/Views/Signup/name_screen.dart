import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:MyUnicircle/Controllers/user_controller.dart';
import 'package:MyUnicircle/Views/Login/login_screen2.dart';
import 'package:MyUnicircle/Views/Signup/otp_screen.dart';

class NameScreen extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final String phone;

  const NameScreen(
      {Key key, this.email, this.username, this.password, this.phone})
      : super(key: key);
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends StateMVC<NameScreen> {
  UserController _con;

  _NameScreenState() : super(UserController()) {
    _con = controller;
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/man_bg.jpeg'),
                    fit: BoxFit.cover)),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              decoration:
                  BoxDecoration(color: Color(0xFFC726AC).withOpacity(.6)),
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(height: 50),
                Image.asset('assets/images/white_logo.png', height: 130),
                SizedBox(height: 40),
                Text('Almost Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 20),
                textField('First name', Icon(Icons.person, color: Colors.white),
                    SizedBox(), firstnameController),
                //SizedBox(height: 30),
                textField('Last name', Icon(Icons.person, color: Colors.white),
                    SizedBox(), lastnameController),
                SizedBox(height: 40),
                outlineBtn(),
                SizedBox(height: 40),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                                color: Colors.white70, fontFamily: 'Poppins'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return LoginScreen();
                                          },
                                        ),
                                      );
                                    })
                            ]),
                      ),
                    ))
              ]))),
        ]));
  }

  Widget textField(String labelText, Widget prefixIcon, Widget suffixIcon,
      TextEditingController controller) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Center(
            child: TextField(
                textCapitalization: TextCapitalization.sentences,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                    labelText: labelText,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon))));
  }

  Widget btnText = Text('SUBMIT',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));

  Widget outlineBtn() {
    return GestureDetector(
        onTap: () {
          if (firstnameController.text == '' || lastnameController.text == '') {
            _con.scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Please fill all required details'),
            ));
          } else {
            _con.setState(() {
              btnText = CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
            });
            _con
                .verifyEmail(
                    firstname: firstnameController.text,
                    lastname: lastnameController.text,
                    email: widget.email,
                    password: widget.password,
                    phone: widget.phone,
                    username: widget.username)
                .whenComplete(() {
              _con.setState(() {
                btnText = Text('SUBMIT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold));
              });
            });
          }
        },
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 2)),
            child: Center(child: btnText)));
  }
}
