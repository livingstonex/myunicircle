import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/Views/Welcome/components/background.dart';
import 'package:MyUnicircle/components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var absHeight = MediaQuery.of(context).size.height;
    var absWidth = MediaQuery.of(context).size.width;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
          child: Column(children: [
        Container(
            height: absHeight * 0.30,
            width: absWidth,
            child: Center(
              child: Image.asset('assets/images/logo.png', height: 150),
            )),
        Container(
          alignment: Alignment.topCenter,
          height: absHeight * 0.70,
          width: absWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Text(
                    'Hello there, Sign up with MyUnicircle and explore all the great features on this amazing platform',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              SizedBox(height: size.height * 0.10),
              RoundedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                text: "Continue",
                press: () {
                  Navigator.pushNamed(
                    context,
                    '/Register',
                  );
                },
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Poppins'),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: TextStyle(
                                    color: Colors.blue, fontFamily: 'Poppins'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      '/Login',
                                    );
                                  })
                          ]),
                    ),
                  ))
            ],
          ),
        )
      ])),
    );
  }
}
