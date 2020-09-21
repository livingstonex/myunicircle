import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('current_user');
    if (user == null) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        '/Onboarding',
        (Route<dynamic> route) => false,
      );
    } else {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        '/NewsFeed',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _buildDisplay();
  }

  @override
  void dispose() {
    super.dispose();
    _buildDisplay();
  }

  _buildDisplay() {
    Timer(Duration(seconds: 6), _navigate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          decoration: BoxDecoration(color: Color(0xFFC726AC).withOpacity(.6)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/white_logo.png', height: 220),
              CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
            ],
          )))
    ]);
  }
}
